import 'package:intl/intl.dart';

const _naira = '\u20A6';

final _currency = NumberFormat.currency(symbol: _naira, decimalDigits: 2);
final _currencyCompact =
    NumberFormat.currency(symbol: _naira, decimalDigits: 0);
final _number = NumberFormat.decimalPattern();

String formatMoney(num? v, {bool compact = false}) {
  if (v == null) return '${_naira}0';
  return (compact ? _currencyCompact : _currency).format(v);
}

String formatMoneyCompact(num? v) {
  if (v == null) return '${_naira}0';
  if (v.abs() >= 1000000) {
    return '$_naira${(v / 1000000).toStringAsFixed(1)}M';
  }
  if (v.abs() >= 1000) {
    return '$_naira${(v / 1000).toStringAsFixed(1)}K';
  }
  return '$_naira${v.toStringAsFixed(0)}';
}

String formatNumber(num? v) => v == null ? '0' : _number.format(v);

String formatPercentDelta(num? v) {
  if (v == null) return '0%';
  final sign = v >= 0 ? '+' : '';
  return '$sign${v.toStringAsFixed(1)}%';
}

String formatDate(String? iso) {
  if (iso == null || iso.isEmpty) return '';
  try {
    return DateFormat.yMMMd().format(DateTime.parse(iso));
  } catch (_) {
    return iso;
  }
}

String formatDateTime(String? iso) {
  if (iso == null || iso.isEmpty) return '';
  try {
    final dt = DateTime.parse(iso);
    return '${DateFormat.yMMMd().format(dt)} · ${DateFormat.jm().format(dt)}';
  } catch (_) {
    return iso;
  }
}

/// "Today · 9 Sept 2026", "Yesterday · 8 Sept 2026", "3 days ago · …".
String formatDayLabel(String? iso) {
  if (iso == null || iso.isEmpty) return '';
  final d = DateTime.tryParse(iso);
  if (d == null) return iso;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(d.year, d.month, d.day);
  final diff = today.difference(day).inDays;
  final pretty = DateFormat('d MMM yyyy').format(d);
  if (diff < 0 || diff > 60) return pretty;
  final rel = switch (diff) {
    0 => 'Today',
    1 => 'Yesterday',
    _ => '$diff days ago',
  };
  return '$rel · $pretty';
}

String formatDateShort(String? iso) {
  if (iso == null || iso.isEmpty) return '';
  final d = DateTime.tryParse(iso);
  if (d == null) return iso;
  return DateFormat('d MMM yyyy').format(d);
}

String formatDayMonth(String? iso) {
  if (iso == null || iso.isEmpty) return '';
  final d = DateTime.tryParse(iso);
  if (d == null) return iso;
  return DateFormat('EEE, d MMM').format(d);
}

int? yearOf(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  return DateTime.tryParse(iso)?.year;
}
