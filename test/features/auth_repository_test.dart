import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/features/auth/data/auth_repository.dart';

import '../helpers/fakes.dart';

void main() {
  test('login stores tokens and returns the response', () async {
    final storage = FakeSecureStorage();
    final adapter = FakeAdapter(
      (o) async => json({'accessToken': 'acc', 'refreshToken': 'ref'}),
    );
    final repo = AuthRepository(
      fakeApi((_) async => json({}), adapter: adapter),
      storage,
    );

    final res = await repo.login(email: 'a@b.com', password: 'pw');
    expect(res.accessToken, 'acc');
    expect(storage.data['access'], 'acc');
    expect(storage.data['refresh'], 'ref');
    expect(adapter.requests.single.path, '/api/v1/auth/login');
    expect(adapter.requests.single.data, {
      'email': 'a@b.com',
      'password': 'pw',
    });
  });

  test('login without an access token throws AuthException', () async {
    final repo = AuthRepository(
      fakeApi((o) async => json({'message': 'No token for you'})),
      FakeSecureStorage(),
    );
    expect(
      () => repo.login(email: 'a@b.com', password: 'pw'),
      throwsA(
        isA<AuthException>().having(
          (e) => e.message,
          'message',
          'No token for you',
        ),
      ),
    );
  });

  test('502 with an HTML body never leaks the Dio message', () async {
    final repo = AuthRepository(
      fakeApi(
        (o) async => ResponseBody.fromString(
          '<html>502 Bad Gateway</html>',
          502,
          headers: {
            Headers.contentTypeHeader: ['text/html'],
          },
        ),
      ),
      FakeSecureStorage(),
    );
    expect(
      () => repo.login(email: 'a@b.com', password: 'pw'),
      throwsA(
        isA<AuthException>().having(
          (e) => e.message,
          'message',
          'Pokopay is temporarily unavailable. Please try again in a few minutes.',
        ),
      ),
    );
  });

  test('a dropped connection on login becomes a plain message', () async {
    final repo = AuthRepository(
      fakeApi((o) async => throw offline(o)),
      FakeSecureStorage(),
    );
    expect(
      () => repo.login(email: 'a@b.com', password: 'pw'),
      throwsA(
        isA<AuthException>().having(
          (e) => e.message,
          'message',
          "Couldn't reach Pokopay. Check your connection and try again.",
        ),
      ),
    );
  });

  test('401 on login becomes a friendly message', () async {
    final repo = AuthRepository(
      fakeApi((o) async => json({}, status: 401)),
      FakeSecureStorage(),
    );
    expect(
      () => repo.login(email: 'a@b.com', password: 'bad'),
      throwsA(
        isA<AuthException>().having(
          (e) => e.message,
          'message',
          'Invalid email or password',
        ),
      ),
    );
  });

  test('backend error message is surfaced', () async {
    final repo = AuthRepository(
      fakeApi((o) async => json({'error': 'Account locked'}, status: 423)),
      FakeSecureStorage(),
    );
    expect(
      () => repo.login(email: 'a@b.com', password: 'pw'),
      throwsA(
        isA<AuthException>().having(
          (e) => e.message,
          'message',
          'Account locked',
        ),
      ),
    );
  });

  group('discoverMidForEmail', () {
    test('prefers the merchant whose email matches', () async {
      final repo = AuthRepository(
        fakeApi(
          (o) async => json({
            'content': [
              {'mid': 'OTHER', 'email': 'x@y.com'},
              {'mid': 'MINE', 'email': 'Me@Shop.com'},
            ],
          }),
        ),
        FakeSecureStorage(),
      );
      expect(await repo.discoverMidForEmail('me@shop.com'), 'MINE');
    });

    test('falls back to the first merchant on the platform', () async {
      final repo = AuthRepository(
        fakeApi((o) async {
          if (o.uri.queryParameters.containsKey('search')) {
            return json({'content': []});
          }
          return json({
            'content': [
              {'mid': 'FIRST', 'email': 'first@x.com'},
            ],
          });
        }),
        FakeSecureStorage(),
      );
      expect(await repo.discoverMidForEmail('admin@pokopay.com'), 'FIRST');
    });

    test('returns null on network failure', () async {
      final repo = AuthRepository(
        fakeApi((o) async => throw offline(o)),
        FakeSecureStorage(),
      );
      expect(await repo.discoverMidForEmail('a@b.com'), isNull);
    });
  });

  test('logout clears tokens even when the request fails', () async {
    final storage = FakeSecureStorage()..data['access'] = 'acc';
    final repo = AuthRepository(
      fakeApi((o) async => json({}, status: 500)),
      storage,
    );
    await repo.logout();
    expect(storage.data.containsKey('access'), isFalse);
  });
}
