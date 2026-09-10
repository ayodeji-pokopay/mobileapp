import 'package:intl/intl.dart';

/// Currency settings applied to every money string in the app. Defaults to
/// Nigerian Naira; `appConfigProvider` overrides them from remote config.
class MoneyFormat {
  MoneyFormat._();

  static String symbol = '\u20A6';
  static String code = 'NGN';
  static String locale = 'en_NG';

  static NumberFormat _currency = NumberFormat.currency(
    symbol: symbol,
    decimalDigits: 2,
    locale: 'en',
  );
  static NumberFormat _whole = NumberFormat.currency(
    symbol: symbol,
    decimalDigits: 0,
    locale: 'en',
  );
  static NumberFormat _number = NumberFormat.decimalPattern('en');

  static void configure({String? symbol, String? code, String? locale}) {
    MoneyFormat.symbol = symbol ?? MoneyFormat.symbol;
    MoneyFormat.code = code ?? MoneyFormat.code;
    MoneyFormat.locale = locale ?? MoneyFormat.locale;
    // intl only knows locales it has data for; fall back to plain English
    // digits/grouping for anything unusual.
    final loc = _supported(MoneyFormat.locale);
    _currency = NumberFormat.currency(
      symbol: MoneyFormat.symbol,
      decimalDigits: 2,
      locale: loc,
    );
    _whole = NumberFormat.currency(
      symbol: MoneyFormat.symbol,
      decimalDigits: 0,
      locale: loc,
    );
    _number = NumberFormat.decimalPattern(loc);
  }

  static String _supported(String locale) {
    try {
      NumberFormat.decimalPattern(locale);
      return locale;
    } catch (_) {
      return 'en';
    }
  }
}

String formatMoney(num? v, {bool compact = false}) {
  if (v == null) return '${MoneyFormat.symbol}0';
  return (compact ? MoneyFormat._whole : MoneyFormat._currency).format(v);
}

String formatMoneyCompact(num? v) {
  final s = MoneyFormat.symbol;
  if (v == null) return '${s}0';
  if (v.abs() >= 1000000) return '$s${(v / 1000000).toStringAsFixed(1)}M';
  if (v.abs() >= 1000) return '$s${(v / 1000).toStringAsFixed(1)}K';
  return '$s${v.toStringAsFixed(0)}';
}

String formatNumber(num? v) => v == null ? '0' : MoneyFormat._number.format(v);

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

/// "just now", "12 min ago", "3 h ago", "2 days ago".
String formatRelativeTime(DateTime t, {DateTime? now}) {
  final diff = (now ?? DateTime.now()).difference(t);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours} h ago';
  return '${diff.inDays} ${diff.inDays == 1 ? 'day' : 'days'} ago';
}

String formatTime(DateTime d) => DateFormat('HH:mm').format(d.toLocal());

/// "August 2026" from "2026-08".
String formatPeriod(String? period) {
  if (period == null || period.isEmpty) return '';
  final d = DateTime.tryParse('$period-01');
  return d == null ? period : DateFormat('MMMM yyyy').format(d);
}

/// Percentage change from [previous] to [current]; null when undefined.
double? percentDelta(num? current, num? previous) {
  if (current == null || previous == null) return null;
  if (previous == 0) return current == 0 ? 0 : null;
  return (current - previous) / previous * 100;
}
