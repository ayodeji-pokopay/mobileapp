import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/models/auth_models.dart';
import '../../../core/storage/secure_storage.dart';
import '../data/auth_repository.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthState {
  const AuthState({
    required this.status,
    this.user,
    this.selectedTenantId,
    this.discoveredMid,
    this.error,
  });

  final AuthStatus status;
  final UserInfoResponse? user;
  final String? selectedTenantId;
  final String? discoveredMid;
  final String? error;

  String? get mid {
    final fromUser = user?.mid;
    if (fromUser != null && fromUser.isNotEmpty) return fromUser;
    return (discoveredMid ?? '').isEmpty ? null : discoveredMid;
  }

  /// True for platform users (admin, CSA) who are not tied to one merchant.
  bool get canSwitchMerchant =>
      status == AuthStatus.authenticated && (user?.mid ?? '').isEmpty;

  AuthState copyWith({
    AuthStatus? status,
    UserInfoResponse? user,
    String? selectedTenantId,
    String? discoveredMid,
    String? error,
  }) => AuthState(
    status: status ?? this.status,
    user: user ?? this.user,
    selectedTenantId: selectedTenantId ?? this.selectedTenantId,
    discoveredMid: discoveredMid ?? this.discoveredMid,
    error: error,
  );
}

class AuthController extends Notifier<AuthState> {
  late final AuthRepository _repo;
  late final SecureStorage _storage;

  @override
  AuthState build() {
    // ignore: avoid_print
    print('[auth] controller.build() — scheduling bootstrap');
    _repo = ref.read(authRepositoryProvider);
    _storage = ref.read(secureStorageProvider);
    Future.microtask(_bootstrap);
    return const AuthState(status: AuthStatus.unknown);
  }

  Future<void> _bootstrap() async {
    try {
      final token = await _storage.readAccessToken().timeout(
        const Duration(seconds: 3),
        onTimeout: () => null,
      );
      if (token == null || token.isEmpty) {
        state = const AuthState(status: AuthStatus.unauthenticated);
        return;
      }
      final user = await _repo.me().timeout(
        const Duration(seconds: 8),
        onTimeout: () => null,
      );
      if (user == null) {
        state = const AuthState(status: AuthStatus.unauthenticated);
        return;
      }
      state = AuthState(status: AuthStatus.authenticated, user: user);
      await _maybeDiscoverMid(user);
    } catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
      );
    }
  }

  Future<void> _maybeDiscoverMid(UserInfoResponse user) async {
    if ((user.mid ?? '').isNotEmpty) return;
    final email = user.email;
    if (email == null || email.isEmpty) return;
    // ignore: avoid_print
    print('[auth] mid is null — searching merchants for $email');
    final mid = await _repo.discoverMidForEmail(email);
    if (mid == null || mid.isEmpty) {
      // ignore: avoid_print
      print('[auth] no merchant found for $email');
      return;
    }
    // ignore: avoid_print
    print('[auth] discovered mid=$mid');
    state = state.copyWith(discoveredMid: mid);
  }

  Future<bool> login(
    String email,
    String password, {
    bool enableBiometric = false,
  }) async {
    state = state.copyWith(error: null);
    try {
      await _repo.login(email: email, password: password);
      final me = await _repo.me();
      if (me == null) {
        state = const AuthState(
          status: AuthStatus.unauthenticated,
          error: 'Could not load profile',
        );
        return false;
      }
      state = AuthState(status: AuthStatus.authenticated, user: me);
      await _maybeDiscoverMid(me);
      if (enableBiometric) {
        await _storage.saveBiometricCredentials(
          email: email,
          password: password,
        );
      }
      return true;
    } on AuthException catch (e) {
      state = AuthState(status: AuthStatus.unauthenticated, error: e.message);
      return false;
    }
  }

  /// Point every merchant screen at [mid]. Only meaningful for users
  /// without a merchant of their own (see [AuthState.canSwitchMerchant]).
  void selectMerchant(String mid) {
    if (mid.isEmpty || mid == state.mid) return;
    state = state.copyWith(discoveredMid: mid);
  }

  Future<bool> loginWithBiometricCredentials() async {
    final creds = await _storage.readBiometricCredentials();
    if (creds == null) {
      state = state.copyWith(error: 'No saved credentials.');
      return false;
    }
    return login(creds.email, creds.password);
  }

  Future<void> logout() async {
    await _repo.logout();
    await _storage.clearBiometricCredentials();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
