import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/lock/app_lock.dart';
import 'package:pokopay/core/storage/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late FakeSecureStorage storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    storage = FakeSecureStorage();
    container = ProviderContainer(
      overrides: [secureStorageProvider.overrideWithValue(storage)],
    );
  });

  tearDown(() => container.dispose());

  test('enable stores a salted hash, never the PIN itself', () async {
    final n = container.read(appLockProvider.notifier);
    await n.enable(pin: '1234');
    final stored = storage.data.values.join(' ');
    expect(stored.contains('1234'), isFalse);
    expect(container.read(appLockProvider).settings.enabled, isTrue);
  });

  test('verifyPin unlocks on the right PIN and counts failures', () async {
    final n = container.read(appLockProvider.notifier);
    await n.enable(pin: '1234');
    n.lockNow();
    expect(container.read(appLockProvider).locked, isTrue);

    expect(await n.verifyPin('0000'), isFalse);
    expect(container.read(appLockProvider).failedAttempts, 1);
    expect(await n.verifyPin('1234'), isTrue);
    expect(container.read(appLockProvider).locked, isFalse);
    expect(container.read(appLockProvider).failedAttempts, 0);
  });

  test('disable clears the PIN and unlocks', () async {
    final n = container.read(appLockProvider.notifier);
    await n.enable(pin: '1234');
    n.lockNow();
    await n.disable();
    final s = container.read(appLockProvider);
    expect(s.settings.enabled, isFalse);
    expect(s.locked, isFalse);
    expect(await n.verifyPin('1234'), isFalse);
  });

  test('settings persist across controllers', () async {
    await container
        .read(appLockProvider.notifier)
        .enable(pin: '9999', timeoutMinutes: 5);
    final again = ProviderContainer(
      overrides: [secureStorageProvider.overrideWithValue(storage)],
    );
    addTearDown(again.dispose);
    again.read(appLockProvider);
    await Future<void>.delayed(Duration.zero);
    expect(again.read(appLockProvider).settings.timeoutMinutes, 5);
    expect(again.read(appLockProvider).settings.enabled, isTrue);
  });
}
