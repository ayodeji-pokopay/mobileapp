import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/push/push_service.dart';

import '../helpers/fakes.dart';

void main() {
  test(
    'registers the token with mid, platform, deviceId and version',
    () async {
      final storage = FakeSecureStorage();
      final adapter = FakeAdapter((o) async => json({}));
      final push = PushService(
        api: fakeApi((_) async => json({}), adapter: adapter),
        storage: storage,
        appVersion: () async => '1.0.0',
      );
      await push.registerToken(mid: 'M1', token: 'fcm-abc');
      await push.registerToken(mid: 'M1', token: 'fcm-abc'); // no duplicate
      expect(adapter.requests.length, 1);
      final r = adapter.requests.single;
      expect(r.path, '/api/v1/devices/push');
      final body = r.data as Map;
      expect(body['mid'], 'M1');
      expect(body['token'], 'fcm-abc');
      expect(body['appVersion'], '1.0.0');
      expect(body['platform'], anyOf('IOS', 'ANDROID'));
      expect(body['deviceId'], await storage.readDeviceId());
    },
  );

  test('unregister deletes by deviceId and never throws', () async {
    final storage = FakeSecureStorage();
    await storage.ensureDeviceId();
    final adapter = FakeAdapter(
      (o) async => json({'message': 'boom'}, status: 500),
    );
    final push = PushService(
      api: fakeApi((_) async => json({}), adapter: adapter),
      storage: storage,
      appVersion: () async => '1.0.0',
    );
    await push.unregister(mid: 'M1');
    expect(adapter.requests.single.method, 'DELETE');
    expect(adapter.requests.single.queryParameters['mid'], 'M1');
  });
}
