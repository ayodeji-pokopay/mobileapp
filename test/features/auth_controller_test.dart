import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/auth_models.dart';
import 'package:pokopay/core/storage/secure_storage.dart';
import 'package:pokopay/features/auth/data/auth_repository.dart';
import 'package:pokopay/features/auth/presentation/auth_controller.dart';

import '../helpers/fakes.dart';

class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository(this.storage) : super(fakeApi((_) async => json({})), storage);
  final FakeSecureStorage storage;

  UserInfoResponse? meResponse;
  String? loginError;
  String? discoveredMid;
  int logoutCalls = 0;

  @override
  Future<AuthResponse> login({required String email, required String password}) async {
    if (loginError != null) throw AuthException(loginError!);
    await storage.writeTokens(accessToken: 'tok');
    return const AuthResponse(accessToken: 'tok');
  }

  @override
  Future<UserInfoResponse?> me() async => meResponse;

  @override
  Future<String?> discoverMidForEmail(String email) async => discoveredMid;

  @override
  Future<void> logout() async {
    logoutCalls++;
    await storage.clear();
  }
}

void main() {
  late FakeSecureStorage storage;
  late FakeAuthRepository repo;

  ProviderContainer container() {
    final c = ProviderContainer(overrides: [
      secureStorageProvider.overrideWithValue(storage),
      authRepositoryProvider.overrideWithValue(repo),
    ]);
    // Keep the controller alive and trigger its bootstrap, as the app does.
    c.listen(authControllerProvider, (_, _) {});
    return c;
  }

  Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 20));

  setUp(() {
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
    repo.meResponse = const UserInfoResponse(email: 'admin@x.com', role: 'ADMIN');
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

  test('login success authenticates and saves biometric credentials', () async {
    repo.meResponse = const UserInfoResponse(email: 'm@x.com', mid: 'M1');
    final c = container();
    addTearDown(c.dispose);
    await settle();
    final ok = await c
        .read(authControllerProvider.notifier)
        .login('m@x.com', 'pw', enableBiometric: true);
    expect(ok, isTrue);
    expect(c.read(authControllerProvider).status, AuthStatus.authenticated);
    expect(await storage.hasBiometricCredentials(), isTrue);
  });

  test('login failure exposes the error', () async {
    repo.loginError = 'Invalid email or password';
    final c = container();
    addTearDown(c.dispose);
    await settle();
    final ok = await c.read(authControllerProvider.notifier).login('m@x.com', 'bad');
    expect(ok, isFalse);
    expect(c.read(authControllerProvider).error, 'Invalid email or password');
    expect(c.read(authControllerProvider).status, AuthStatus.unauthenticated);
  });

  test('logout clears biometric credentials', () async {
    storage.data['access'] = 'tok';
    storage.data['bio_email'] = 'm@x.com';
    storage.data['bio_password'] = 'pw';
    repo.meResponse = const UserInfoResponse(email: 'm@x.com', mid: 'M1');
    final c = container();
    addTearDown(c.dispose);
    await settle();
    await c.read(authControllerProvider.notifier).logout();
    expect(repo.logoutCalls, 1);
    expect(await storage.hasBiometricCredentials(), isFalse);
    expect(c.read(authControllerProvider).status, AuthStatus.unauthenticated);
  });
}
