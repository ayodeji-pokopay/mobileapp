import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/cache/cache_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('round-trips JSON with a timestamp', () async {
    final store = CacheStore();
    await store.write('k', {'a': 1, 'b': 'x'});
    final entry = await store.read('k');
    expect(entry, isNotNull);
    expect(entry!.json, {'a': 1, 'b': 'x'});
    expect(DateTime.now().difference(entry.savedAt).inSeconds, lessThan(5));
  });

  test('missing keys and corrupt values read as null', () async {
    SharedPreferences.setMockInitialValues({'cache:bad': 'not json'});
    final store = CacheStore();
    expect(await store.read('missing'), isNull);
    expect(await store.read('bad'), isNull);
  });

  test('clear removes only cache keys', () async {
    SharedPreferences.setMockInitialValues({'pref_daily_report': true});
    final store = CacheStore();
    await store.write('one', {});
    await store.clear();
    expect(await store.read('one'), isNull);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('pref_daily_report'), isTrue);
  });
}
