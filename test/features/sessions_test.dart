import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/features/auth/data/auth_repository.dart';

void main() {
  test('parses a session row from the backend', () {
    final s = SessionInfo.fromJson({
      'tokenId': 'abc',
      'deviceInfo': 'Dart/3.11 (dart:io)',
      'ipAddress': '102.89.1.1',
      'location': '102.89.1.1',
      'createdAt': '2026-09-09T10:00:00Z',
      'lastActivity': '2026-09-09T12:00:00Z',
      'expiresAt': '2026-09-16T10:00:00Z',
      'active': true,
      'current': true,
    });
    expect(s.tokenId, 'abc');
    expect(s.isApp, isTrue);
    expect(s.current, isTrue);
    expect(s.lastActivity, DateTime.utc(2026, 9, 9, 12));
  });

  test('browser sessions are not flagged as the app', () {
    final s = SessionInfo.fromJson({
      'tokenId': 'x',
      'deviceInfo': 'Mozilla/5.0 (Macintosh)',
      'active': true,
      'current': false,
    });
    expect(s.isApp, isFalse);
    expect(s.createdAt, isNull);
  });
}
