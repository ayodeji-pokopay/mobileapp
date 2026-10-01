import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/cache/cache_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('corrupted cache entries are ignored, not thrown', () async {
    SharedPreferences.setMockInitialValues({
      'cache:summary:M': '{not json',
      'cache:wallet:M': '[]',
      'cache:terminals:M': '{"json": "string", "savedAt": "yesterday"}',
    });
    final store = CacheStore(prefs: await SharedPreferences.getInstance());
    for (final k in ['summary:M', 'wallet:M', 'terminals:M', 'missing']) {
      expect(() async => await store.read(k), returnsNormally, reason: k);
      expect(await store.read(k), isNull, reason: k);
    }
  });

  test('a large payload round-trips', () async {
    SharedPreferences.setMockInitialValues({});
    final store = CacheStore(prefs: await SharedPreferences.getInstance());
    final big = {
      'content': List.generate(
        5000,
        (i) => {'i': i, 'ref': 'R$i', 'amount': i * 1.5},
      ),
    };
    await store.write('big', big);
    final e = await store.read('big');
    expect((e!.json['content'] as List).length, 5000);
  });
}
