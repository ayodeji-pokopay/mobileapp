import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/models/auth_models.dart';
import '../../../core/auth/session_events.dart';
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
    this.errorCode,
    this.sessionExpired = false,
  });

  final AuthStatus status;
  final UserInfoResponse? user;
  final String? selectedTenantId;
  final String? discoveredMid;
  final String? error;
  final String? errorCode;

  /// True when the app signed the user out because the session could not
  /// be refreshed; the login screen shows a hint.
  final bool sessionExpired;

  String? get mid {
    final fromUser = user?.mid;
    if (fromUser != null && fromUser.isNotEmpty) return fromUser;
    return (discoveredMid ?? '').isEmpty ? null : discoveredMid;
  }

  /// True for platform users (admin, CSA) who are not tied to one merchant.
  bool get canSwitchMerchant =>
      status == AuthStatus.authenticated && (user?.mid ?? '').isEmpty;

  bool hasPermission(String permission) {
    final perms = user?.permissions ?? const [];
    return perms.isEmpty || perms.contains(permission);
  }

  AuthState copyWith({
    AuthStatus? status,
    UserInfoResponse? user,
    String? selectedTenantId,
    String? discoveredMid,
    String? error,
    String? errorCode,
    bool? sessionExpired,
  }) => AuthState(
    status: status ?? this.status,
    user: user ?? this.user,
    selectedTenantId: selectedTenantId ?? this.selectedTenantId,
    discoveredMid: discoveredMid ?? this.discoveredMid,
    error: error,
    errorCode: errorCode,
    sessionExpired: sessionExpired ?? this.sessionExpired,
  );
}

class AuthController extends Notifier<AuthState> {
  late final AuthRepository _repo;
  late final SecureStorage _storage;

  @override
  AuthState build() {
    _repo = ref.read(authRepositoryProvider);
    _storage = ref.read(secureStorageProvider);
    ref.listen(sessionEventsProvider, (_, _) => _onSessionExpired());
    Future.microtask(_bootstrap);
    return const AuthState(status: AuthStatus.unknown);
  }

  void _onSessionExpired() {
    if (state.status != AuthStatus.authenticated) return;
    state = const AuthState(
      status: AuthStatus.unauthenticated,
      sessionExpired: true,
    );
  }

  Future<void> _bootstrap() async {
    try {
      final token = await _storage.readAccessToken().timeout(
        const Duration(seconds: 3),
        onTimeout: () => null,
      );
      final refresh = await _storage.readRefreshToken().timeout(
        const Duration(seconds: 3),
        onTimeout: () => null,
      );
      if ((token == null || token.isEmpty) &&
          (refresh == null || refresh.isEmpty)) {
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
    final mid = await _repo.discoverMidForEmail(email);
    if (mid == null || mid.isEmpty) return;
    state = state.copyWith(discoveredMid: mid);
  }

  Future<bool> _finishLogin({bool enableBiometric = false}) async {
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
      try {
        await _repo.enrolDevice();
      } on AuthException {
        // Enrolment is optional; the password login already succeeded.
      }
    }
    return true;
  }

  Future<bool> login(
    String email,
    String password, {
    bool enableBiometric = false,
  }) async {
    state = state.copyWith(error: null, sessionExpired: false);
    try {
      await _repo.login(email: email, password: password);
      return _finishLogin(enableBiometric: enableBiometric);
    } on AuthException catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        error: e.message,
        errorCode: e.code,
      );
      return false;
    }
  }

  /// Signs in with the enrolled device token. The caller must have passed
  /// the OS biometric prompt first.
  Future<bool> loginWithDevice() async {
    state = state.copyWith(error: null, sessionExpired: false);
    try {
      await _repo.deviceLogin();
      return _finishLogin();
    } on AuthException catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        error: e.message,
        errorCode: e.code,
      );
      return false;
    }
  }

  /// Point every merchant screen at [mid]. Only meaningful for users
  /// without a merchant of their own (see [AuthState.canSwitchMerchant]).
  void selectMerchant(String mid) {
    if (mid.isEmpty || mid == state.mid) return;
    state = state.copyWith(discoveredMid: mid);
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
