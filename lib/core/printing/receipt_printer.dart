import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/models/transaction_models.dart';
import '../../shared/format.dart';

class PrinterDevice {
  const PrinterDevice({required this.name, required this.address});
  final String name;
  final String address;
}

class PrinterSettings {
  const PrinterSettings({this.address, this.name, this.paper = 58});
  final String? address;
  final String? name;

  /// 58 or 80 mm
  final int paper;
  bool get configured => (address ?? '').isNotEmpty;
}

class PrinterException implements Exception {
  PrinterException(this.code);
  final String
  code; // BLUETOOTH_OFF | NOT_CONFIGURED | CONNECT_FAILED | WRITE_FAILED
}

/// Prints receipts to a paired ESC/POS Bluetooth thermal printer.
class ReceiptPrinter {
  static const _addrKey = 'printer_address';
  static const _nameKey = 'printer_name';
  static const _paperKey = 'printer_paper';

  Future<PrinterSettings> settings() async {
    final p = await SharedPreferences.getInstance();
    return PrinterSettings(
      address: p.getString(_addrKey),
      name: p.getString(_nameKey),
      paper: p.getInt(_paperKey) ?? 58,
    );
  }

  Future<void> save(PrinterDevice? d, {int? paper}) async {
    final p = await SharedPreferences.getInstance();
    if (d == null) {
      await p.remove(_addrKey);
      await p.remove(_nameKey);
    } else {
      await p.setString(_addrKey, d.address);
      await p.setString(_nameKey, d.name);
    }
    if (paper != null) await p.setInt(_paperKey, paper);
  }

  Future<bool> bluetoothOn() => PrintBluetoothThermal.bluetoothEnabled;

  Future<List<PrinterDevice>> paired() async {
    final list = await PrintBluetoothThermal.pairedBluetooths;
    return [
      for (final b in list) PrinterDevice(name: b.name, address: b.macAdress),
    ];
  }

  Future<void> _connect(PrinterSettings s) async {
    if (!s.configured) throw PrinterException('NOT_CONFIGURED');
    if (!await bluetoothOn()) throw PrinterException('BLUETOOTH_OFF');
    if (await PrintBluetoothThermal.connectionStatus) return;
    final ok = await PrintBluetoothThermal.connect(
      macPrinterAddress: s.address!,
    );
    if (!ok) throw PrinterException('CONNECT_FAILED');
  }

  Future<void> _write(List<int> bytes) async {
    final ok = await PrintBluetoothThermal.writeBytes(bytes);
    if (!ok) throw PrinterException('WRITE_FAILED');
  }

  Future<Generator> _generator(int paper) async {
    final profile = await CapabilityProfile.load();
    return Generator(paper == 80 ? PaperSize.mm80 : PaperSize.mm58, profile);
  }

  Future<void> printTest(String business) async {
    final s = await settings();
    await _connect(s);
    final g = await _generator(s.paper);
    final bytes = <int>[
      ...g.text(
        'POKOPAY',
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
      ...g.text(business, styles: const PosStyles(align: PosAlign.center)),
      ...g.hr(),
      ...g.text(
        'Printer test OK',
        styles: const PosStyles(align: PosAlign.center),
      ),
      ...g.feed(2),
      ...g.cut(),
    ];
    await _write(bytes);
  }

  Future<void> printReceipt(
    TransactionResponse t, {
    required String business,
    required String statusLabel,
  }) async {
    final s = await settings();
    await _connect(s);
    final g = await _generator(s.paper);
    final d = DateTime.tryParse(t.transactionDate ?? '')?.toLocal();
    final when = d == null
        ? ''
        : '${formatDateShort(t.transactionDate)} ${formatTime(d)}';
    // Thermal fonts rarely have the Naira glyph; print "NGN".
    String money(num? v) =>
        'NGN ${formatMoney(v).replaceFirst(MoneyFormat.symbol, '')}';
    List<int> kv(String k, String v) => g.row([
      PosColumn(text: k, width: 5),
      PosColumn(
        text: v,
        width: 7,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    final bytes = <int>[
      ...g.text(
        'POKOPAY',
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
      ...g.text(business, styles: const PosStyles(align: PosAlign.center)),
      ...g.text(when, styles: const PosStyles(align: PosAlign.center)),
      ...g.hr(),
      ...g.text(
        statusLabel.toUpperCase(),
        styles: const PosStyles(align: PosAlign.center, bold: true),
      ),
      ...g.text(
        money(t.amount),
        styles: const PosStyles(
          align: PosAlign.center,
          bold: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
      ),
      ...g.hr(),
      if ((t.maskedPan ?? '').isNotEmpty)
        ...kv('Card', '${(t.scheme ?? '').toUpperCase()} ${t.maskedPan}'),
      if ((t.cardBank ?? '').isNotEmpty) ...kv('Bank', t.cardBank!),
      if ((t.tid ?? '').isNotEmpty) ...kv('Terminal', t.tid!),
      if ((t.stan ?? '').isNotEmpty) ...kv('STAN', t.stan!),
      if ((t.rrn ?? '').isNotEmpty) ...kv('RRN', t.rrn!),
      if ((t.authCode ?? '').isNotEmpty) ...kv('Auth', t.authCode!),
      if ((t.responseCode ?? '').isNotEmpty) ...kv('Resp', t.responseCode!),
      ...g.hr(),
      ...g.text(
        'Ref: ${t.reference ?? ''}',
        styles: const PosStyles(align: PosAlign.center),
      ),
      ...g.text(
        'Powered by Pokopay',
        styles: const PosStyles(align: PosAlign.center),
      ),
      ...g.feed(3),
      ...g.cut(),
    ];
    await _write(bytes);
  }
}

final receiptPrinterProvider = Provider<ReceiptPrinter>(
  (_) => ReceiptPrinter(),
);
final printerSettingsProvider = FutureProvider<PrinterSettings>((ref) {
  return ref.watch(receiptPrinterProvider).settings();
});
