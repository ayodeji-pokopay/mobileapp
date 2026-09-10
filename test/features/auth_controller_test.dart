import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokopay/core/api/models/auth_models.dart';
import 'package:pokopay/core/auth/session_events.dart';
import 'package:pokopay/core/storage/secure_storage.dart';
import 'package:pokopay/features/auth/data/auth_repository.dart';
import 'package:pokopay/features/auth/presentation/auth_controller.dart';

import '../helpers/fakes.dart';

class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository(this.storage)
    : super(fakeApi((_) async => json({})), storage);
  final FakeSecureStorage storage;

  UserInfoResponse? meResponse;
  String? loginError;
  String? discoveredMid;
  int logoutCalls = 0;
  int enrolCalls = 0;

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    if (loginError != null) throw AuthException(loginError!);
    await storage.writeTokens(accessToken: 'tok');
    return const AuthResponse(accessToken: 'tok');
  }

  @override
  Future<UserInfoResponse?> me() async => meResponse;

  @override
  Future<String?> discoverMidForEmail(String email) async => discoveredMid;

  @override
  Future<void> enrolDevice() async {
    enrolCalls++;
    await storage.writeDeviceToken('dvt-1');
  }

  @override
  Future<AuthResponse> deviceLogin() async {
    if ((storage.data['deviceToken'] ?? '').isEmpty) {
      throw AuthException('Not enrolled', code: AuthException.deviceReenrol);
    }
    await storage.writeTokens(accessToken: 'tok');
    return const AuthResponse(accessToken: 'tok');
  }

  @override
  Future<void> logout() async {
    logoutCalls++;
    await storage.clearDeviceToken();
    await storage.clear();
  }
}

void main() {
  late FakeSecureStorage storage;
  late FakeAuthRepository repo;

  ProviderContainer container() {
    final c = ProviderContainer(
      overrides: [
        secureStorageProvider.overrideWithValue(storage),
        authRepositoryProvider.overrideWithValue(repo),
      ],
    );
    // Keep the controller alive and trigger its bootstrap, as the app does.
    c.listen(authControllerProvider, (_, _) {});
    return c;
  }

  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 20));

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    storage = FakeSecureStorage();
    repo = FakeAuthRepository(storage);
  });

  test('bootstraps to unauthenticated when no token is stored', () async {
    final c = container();
    addTearDown(c.dispose);
    expect(c.read(authControllerProvider).status, AuthStatus.unknown);
    await settle();
    expect(c.read(authControllerProvider).status, AuthStatus.unauthenticated);
  });

  test('bootstraps to authenticated with a stored token and profile', () async {
    storage.data['access'] = 'tok';
    repo.meResponse = const UserInfoResponse(email: 'm@x.com', mid: 'M1');
    final c = container();
    addTearDown(c.dispose);
    await settle();
    final s = c.read(authControllerProvider);
    expect(s.status, AuthStatus.authenticated);
    expect(s.mid, 'M1');
    expect(s.canSwitchMerchant, isFalse);
  });

  test('platform users discover a merchant and can switch', () async {
    storage.data['access'] = 'tok';
    repo.meResponse = const UserInfoResponse(
      email: 'admin@x.com',
      role: 'ADMIN',
    );
    repo.discoveredMid = 'FIRST';
    final c = container();
    addTearDown(c.dispose);
    await settle();
    final s = c.read(authControllerProvider);
    expect(s.mid, 'FIRST');
    expect(s.canSwitchMerchant, isTrue);

    c.read(authControllerProvider.notifier).selectMerchant('SECOND');
    expect(c.read(authControllerProvider).mid, 'SECOND');
  });

  test('login success authenticates and enrols the device', () async {
    repo.meResponse = const UserInfoResponse(email: 'm@x.com', mid: 'M1');
    final c = container();
    addTearDown(c.dispose);
    await settle();
    final ok = await c
        .read(authControllerProvider.notifier)
        .login('m@x.com', 'pw', enableBiometric: true);
    expect(ok, isTrue);
    expect(c.read(authControllerProvider).status, AuthStatus.authenticated);
    expect(repo.enrolCalls, 1);
    expect(await storage.hasDeviceToken(), isTrue);
  });

  test('device login signs in with the enrolled token', () async {
    repo.meResponse = const UserInfoResponse(email: 'm@x.com', mid: 'M1');
    storage.data['deviceToken'] = 'dvt-1';
    final c = container();
    addTearDown(c.dispose);
    await settle();
    final ok = await c.read(authControllerProvider.notifier).loginWithDevice();
    expect(ok, isTrue);
    expect(c.read(authControllerProvider).status, AuthStatus.authenticated);
  });

  test('device login without enrolment reports re-enrol', () async {
    final c = container();
    addTearDown(c.dispose);
    await settle();
    final ok = await c.read(authControllerProvider.notifier).loginWithDevice();
    expect(ok, isFalse);
    expect(
      c.read(authControllerProvider).errorCode,
      AuthException.deviceReenrol,
    );
  });

  test('session expiry event signs the user out', () async {
    storage.data['access'] = 'tok';
    repo.meResponse = const UserInfoResponse(email: 'm@x.com', mid: 'M1');
    final c = container();
    addTearDown(c.dispose);
    await settle();
    expect(c.read(authControllerProvider).status, AuthStatus.authenticated);
    c.read(sessionEventsProvider.notifier).expire();
    await settle();
    final s = c.read(authControllerProvider);
    expect(s.status, AuthStatus.unauthenticated);
    expect(s.sessionExpired, isTrue);
  });

  test('login failure exposes the error', () async {
    repo.loginError = 'Invalid email or password';
    final c = container();
    addTearDown(c.dispose);
    await settle();
    final ok = await c
        .read(authControllerProvider.notifier)
        .login('m@x.com', 'bad');
    expect(ok, isFalse);
    expect(c.read(authControllerProvider).error, 'Invalid email or password');
    expect(c.read(authControllerProvider).status, AuthStatus.unauthenticated);
  });

  test('logout revokes the device token', () async {
    storage.data['access'] = 'tok';
    storage.data['deviceToken'] = 'dvt-1';
    repo.meResponse = const UserInfoResponse(email: 'm@x.com', mid: 'M1');
    final c = container();
    addTearDown(c.dispose);
    await settle();
    await c.read(authControllerProvider.notifier).logout();
    expect(repo.logoutCalls, 1);
    expect(await storage.hasDeviceToken(), isFalse);
    expect(c.read(authControllerProvider).status, AuthStatus.unauthenticated);
  });
}
