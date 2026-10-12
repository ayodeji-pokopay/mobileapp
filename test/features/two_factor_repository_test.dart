import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/features/auth/data/auth_repository.dart';

import '../helpers/fakes.dart';

void main() {
  test(
    'a correct password on a 2FA account yields the code step, not tokens',
    () async {
      final storage = FakeSecureStorage();
      final repo = AuthRepository(
        fakeApi(
          (o) async => json({
            'mfaRequired': true,
            'mfaToken': 'mfa_abc',
            'email': 'a@b.com',
          }),
        ),
        storage,
      );

      await expectLater(
        () => repo.login(email: 'a@b.com', password: 'pw'),
        throwsA(
          isA<MfaStepRequired>()
              .having((s) => s.setup, 'setup', false)
              .having((s) => s.token, 'token', 'mfa_abc'),
        ),
      );
      expect(storage.data['access'], isNull);
    },
  );

  test('an account that has not enrolled yet gets the setup step', () async {
    final repo = AuthRepository(
      fakeApi(
        (o) async => json({'mfaSetupRequired': true, 'setupToken': 'mfs_xyz'}),
      ),
      FakeSecureStorage(),
    );
    await expectLater(
      () => repo.login(email: 'a@b.com', password: 'pw'),
      throwsA(
        isA<MfaStepRequired>()
            .having((s) => s.setup, 'setup', true)
            .having((s) => s.token, 'token', 'mfs_xyz'),
      ),
    );
  });

  test(
    'verifyMfa sends the code without a bearer and stores the session',
    () async {
      final storage = FakeSecureStorage();
      final adapter = FakeAdapter(
        (o) async => json({'accessToken': 'acc', 'refreshToken': 'ref'}),
      );
      final repo = AuthRepository(
        fakeApi((_) async => json({}), adapter: adapter),
        storage,
      );

      await repo.verifyMfa(mfaToken: 'mfa_abc', code: '123456');
      final req = adapter.requests.single;
      expect(req.path, '/api/v1/auth/mfa/verify');
      expect(req.data, {'mfaToken': 'mfa_abc', 'code': '123456'});
      expect(req.headers['Authorization'], isNull);
      expect(storage.data['access'], 'acc');
    },
  );

  test('a recovery code is sent as recoveryCode', () async {
    final adapter = FakeAdapter((o) async => json({'accessToken': 'acc'}));
    final repo = AuthRepository(
      fakeApi((_) async => json({}), adapter: adapter),
      FakeSecureStorage(),
    );
    await repo.verifyMfa(mfaToken: 'mfa_abc', recoveryCode: 'abcd-efgh');
    expect(adapter.requests.single.data, {
      'mfaToken': 'mfa_abc',
      'recoveryCode': 'abcd-efgh',
    });
  });

  test(
    'a wrong code is MFA_INVALID_CODE and an expired step is MFA_EXPIRED',
    () async {
      final wrong = AuthRepository(
        fakeApi((o) async => json({'error': 'MFA_INVALID_CODE'}, status: 400)),
        FakeSecureStorage(),
      );
      await expectLater(
        () => wrong.verifyMfa(mfaToken: 't', code: '000000'),
        throwsA(
          isA<AuthException>().having(
            (e) => e.code,
            'code',
            AuthException.mfaInvalidCode,
          ),
        ),
      );
      final expired = AuthRepository(
        fakeApi(
          (o) async => json({'error': 'MFA_CHALLENGE_EXPIRED'}, status: 401),
        ),
        FakeSecureStorage(),
      );
      await expectLater(
        () => expired.verifyMfa(mfaToken: 't', code: '123456'),
        throwsA(
          isA<AuthException>().having(
            (e) => e.code,
            'code',
            AuthException.mfaExpired,
          ),
        ),
      );
    },
  );

  test(
    'setup returns the secret, confirm stores the session and returns recovery codes',
    () async {
      final storage = FakeSecureStorage();
      final adapter = FakeAdapter((o) async {
        if (o.path.endsWith('/setup')) {
          return json({
            'secret': 'JBSWY3DPEHPK3PXP',
            'otpauthUri':
                'otpauth://totp/Pokopay:a@b.com?secret=JBSWY3DPEHPK3PXP',
          });
        }
        return json({
          'recoveryCodes': ['aaaa-bbbb', 'cccc-dddd'],
          'session': {'accessToken': 'acc', 'refreshToken': 'ref'},
        });
      });
      final repo = AuthRepository(
        fakeApi((_) async => json({}), adapter: adapter),
        storage,
      );

      final info = await repo.startMfaSetup('mfs_xyz');
      expect(info.secret, 'JBSWY3DPEHPK3PXP');
      expect(adapter.requests.first.data, {'setupToken': 'mfs_xyz'});

      final codes = await repo.confirmMfaSetup(
        setupToken: 'mfs_xyz',
        code: '123456',
      );
      expect(codes, ['aaaa-bbbb', 'cccc-dddd']);
      expect(adapter.requests.last.path, '/api/v1/auth/mfa/confirm');
      expect(storage.data['access'], 'acc');
    },
  );
}
