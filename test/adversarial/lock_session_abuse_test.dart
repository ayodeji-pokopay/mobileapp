import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/lock/app_lock.dart';
import 'package:pokopay/core/session/session_timeout.dart';
import 'package:pokopay/core/storage/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer c;
  late FakeSecureStorage storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    storage = FakeSecureStorage();
    c = ProviderContainer(
      overrides: [secureStorageProvider.overrideWithValue(storage)],
    );
    await Future<void>.delayed(Duration.zero);
  });
  tearDown(() => c.dispose());

  test('garbage PINs never unlock and never throw', () async {
    final n = c.read(appLockProvider.notifier);
    await n.enable(pin: '1234');
    n.lockNow();
    // Four wrong guesses keep the lock up; the fifth signs the user out.
    for (final bad in ['', 'abcd', '12345', '١٢٣٤']) {
      expect(await n.verifyPin(bad), isFalse, reason: '"$bad"');
      expect(c.read(appLockProvider).locked, isTrue, reason: '"$bad"');
    }
    expect(c.read(appLockProvider).failedAttempts, 4);
    expect(await n.verifyPin(' 1234'), isFalse);
    expect(
      c.read(appLockProvider).failedAttempts,
      0,
      reason: 'signed out after 5',
    );
  });

  test('verifying with no PIN set fails closed', () async {
    final n = c.read(appLockProvider.notifier);
    n.lockNow();
    expect(await n.verifyPin('1234'), isFalse);
    expect(c.read(appLockProvider).hasPin, isFalse);
  });

  test('timeout settings reject nonsense values gracefully', () async {
    final n = c.read(appLockProvider.notifier);
    await n.setTimeout(-5);
    expect(
      c.read(appLockProvider).settings.timeoutMinutes,
      greaterThanOrEqualTo(0),
    );
  });

  test('idle sign-out ignores a clock set in the past or a zero timeout', () {
    final now = DateTime(2026, 10, 1, 12);
    expect(idleSignOutDue(now.add(const Duration(hours: 5)), now, 15), isFalse);
    expect(
      idleSignOutDue(now.subtract(const Duration(days: 9)), now, 0),
      isFalse,
    );
    expect(
      idleSignOutDue(now.subtract(const Duration(days: 9)), now, -1),
      isFalse,
    );
  });

  test('session timeout controller clamps odd persisted values', () async {
    SharedPreferences.setMockInitialValues({'session_timeout_minutes': -30});
    final c2 = ProviderContainer(
      overrides: [secureStorageProvider.overrideWithValue(storage)],
    );
    addTearDown(c2.dispose);
    c2.read(sessionTimeoutProvider);
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(c2.read(sessionTimeoutProvider), greaterThanOrEqualTo(0));
  });
}
