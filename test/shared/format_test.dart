import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/shared/format.dart';

void main() {
  setUp(() => MoneyFormat.configure(symbol: '₦', code: 'NGN', locale: 'en_NG'));

  group('formatMoney', () {
    test('formats Naira with two decimals and grouping', () {
      expect(formatMoney(1234.5), '₦1,234.50');
      expect(formatMoney(0), '₦0.00');
    });
    test('null renders as zero', () {
      expect(formatMoney(null), '₦0');
    });
    test('compact drops decimals', () {
      expect(formatMoney(2840500, compact: true), '₦2,840,500');
    });
    test('symbol follows MoneyFormat.configure', () {
      MoneyFormat.configure(symbol: 'GH₵', code: 'GHS');
      expect(formatMoney(10), 'GH₵10.00');
      expect(MoneyFormat.code, 'GHS');
    });
  });

  group('formatMoneyCompact', () {
    test('abbreviates thousands and millions', () {
      expect(formatMoneyCompact(2500000), '₦2.5M');
      expect(formatMoneyCompact(74580), '₦74.6K');
      expect(formatMoneyCompact(999), '₦999');
    });
  });

  group('dates', () {
    test('formatDayLabel marks today and yesterday', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day).toIso8601String();
      final yesterday = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(const Duration(days: 1)).toIso8601String();
      expect(formatDayLabel(today), startsWith('Today · '));
      expect(formatDayLabel(yesterday), startsWith('Yesterday · '));
    });
    test('formatDayLabel returns plain date for old dates', () {
      expect(formatDayLabel('2020-01-15'), '15 Jan 2020');
    });
    test('formatDateShort tolerates garbage', () {
      expect(formatDateShort('not-a-date'), 'not-a-date');
      expect(formatDateShort(null), '');
    });
    test('yearOf extracts the year', () {
      expect(yearOf('2026-09-09'), 2026);
      expect(yearOf(null), isNull);
    });
  });

  group('formatRelativeTime', () {
    final now = DateTime(2026, 9, 10, 12);
    test('buckets by minute, hour, day', () {
      expect(formatRelativeTime(now, now: now), 'just now');
      expect(
        formatRelativeTime(now.subtract(const Duration(minutes: 12)), now: now),
        '12 min ago',
      );
      expect(
        formatRelativeTime(now.subtract(const Duration(hours: 3)), now: now),
        '3 h ago',
      );
      expect(
        formatRelativeTime(now.subtract(const Duration(days: 1)), now: now),
        '1 day ago',
      );
      expect(
        formatRelativeTime(now.subtract(const Duration(days: 4)), now: now),
        '4 days ago',
      );
    });
  });
}
