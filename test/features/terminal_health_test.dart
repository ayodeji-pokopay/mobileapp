import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/business_models.dart';
import 'package:pokopay/features/dashboard/presentation/dashboard_providers.dart';

void main() {
  test('server verdict wins over heartbeat age', () {
    final stale = DateTime.now()
        .subtract(const Duration(days: 3))
        .toIso8601String();
    expect(
      terminalHealth(TerminalResponse(health: 'HEALTHY', lastHeartbeat: stale)),
      TerminalHealth.online,
    );
    expect(
      terminalHealth(
        const TerminalResponse(
          health: 'DEGRADED',
          healthReasons: ['PRINTER_OUT_OF_PAPER'],
        ),
      ),
      TerminalHealth.degraded,
    );
    expect(
      terminalHealth(
        const TerminalResponse(health: 'DEGRADED', healthReasons: ['STALE']),
      ),
      TerminalHealth.idle,
    );
    expect(
      terminalHealth(const TerminalResponse(health: 'OFFLINE')),
      TerminalHealth.offline,
    );
  });

  test('falls back to heartbeat age on older backends', () {
    final fresh = DateTime.now()
        .subtract(const Duration(minutes: 2))
        .toIso8601String();
    expect(
      terminalHealth(TerminalResponse(lastHeartbeat: fresh)),
      TerminalHealth.online,
    );
  });

  test('telemetry fields parse', () {
    final t = TerminalResponse.fromJson({
      'tid': '2POK0005',
      'connectivity': 'ONLINE',
      'health': 'DEGRADED',
      'healthReasons': ['PRINTER_OUT_OF_PAPER'],
      'batteryPercent': 82,
      'charging': true,
      'connectionType': 'WIFI',
      'signal': 3,
      'printerStatus': 'OUT_OF_PAPER',
      'appVersion': '1.4.2',
    });
    expect(t.batteryPercent, 82);
    expect(t.charging, isTrue);
    expect(t.signal, 3);
    expect(t.healthReasons, ['PRINTER_OUT_OF_PAPER']);
  });
}
