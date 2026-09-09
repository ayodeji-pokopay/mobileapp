import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/cache/cache_store.dart';
import 'package:pokopay/features/merchant/data/merchant_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fakes.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  const summaryJson = {
    'mid': 'M1',
    'totalSettlements': 3,
    'totalSettledAmount': 1500.5,
    'pendingAmount': 200,
    'todayTransactions': 2,
    'todaySales': 100,
  };

  test('fetchSummary parses the response and sends mid', () async {
    final adapter = FakeAdapter((o) async => json(summaryJson));
    final repo = MerchantRepository(fakeApi((_) async => json({}), adapter: adapter));
    final s = await repo.fetchSummary(mid: 'M1');
    expect(s.totalSettlements, 3);
    expect(s.totalSettledAmount, 1500.5);
    expect(adapter.requests.single.uri.queryParameters['mid'], 'M1');
    expect(adapter.requests.single.uri.path, '/api/v1/merchant/reports/summary');
  });

  test('serves the cached copy when the network is unreachable', () async {
    var online = true;
    DateTime? staleSince;
    var freshCalls = 0;
    final repo = MerchantRepository(
      fakeApi((o) async {
        if (!online) throw offline(o);
        return json(summaryJson);
      }),
      cache: CacheStore(),
      onServedFromCache: (t) => staleSince = t,
      onFresh: () => freshCalls++,
    );

    final first = await repo.fetchSummary(mid: 'M1');
    expect(first.pendingAmount, 200);
    expect(freshCalls, 1);
    expect(staleSince, isNull);

    online = false;
    final second = await repo.fetchSummary(mid: 'M1');
    expect(second.pendingAmount, 200);
    expect(staleSince, isNotNull);
  });

  test('rethrows when offline and nothing is cached', () async {
    final repo = MerchantRepository(
      fakeApi((o) async => throw offline(o)),
      cache: CacheStore(),
    );
    expect(repo.fetchSummary(mid: 'M1'), throwsA(isA<DioException>()));
  });

  test('server errors are not masked by the cache', () async {
    var fail = false;
    final repo = MerchantRepository(
      fakeApi((o) async {
        if (fail) return json({'message': 'boom'}, status: 500);
        return json(summaryJson);
      }),
      cache: CacheStore(),
    );
    await repo.fetchSummary(mid: 'M1');
    fail = true;
    expect(repo.fetchSummary(mid: 'M1'), throwsA(isA<DioException>()));
  });

  test('fetchTerminals caches list responses', () async {
    var online = true;
    final repo = MerchantRepository(
      fakeApi((o) async {
        if (!online) throw offline(o);
        return json(['T1', 'T2']);
      }),
      cache: CacheStore(),
    );
    expect(await repo.fetchTerminals(mid: 'M1'), ['T1', 'T2']);
    online = false;
    expect(await repo.fetchTerminals(mid: 'M1'), ['T1', 'T2']);
  });

  test('searchMerchants drops rows without a mid', () async {
    final repo = MerchantRepository(fakeApi((o) async => json({
          'content': [
            {'mid': 'A', 'merchantName': 'Alpha', 'email': 'a@x.com'},
            {'mid': '', 'merchantName': 'NoMid'},
            {'merchantName': 'Missing'},
          ]
        })));
    final list = await repo.searchMerchants(search: 'al');
    expect(list.map((m) => m.mid), ['A']);
    expect(list.single.name, 'Alpha');
  });

  test('ApiError extracts the backend message', () {
    final e = DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(
        requestOptions: RequestOptions(path: '/x'),
        statusCode: 409,
        data: {'message': 'Wallet frozen'},
      ),
    );
    final err = ApiError.from(e);
    expect(err.message, 'Wallet frozen');
    expect(err.statusCode, 409);
  });
}
