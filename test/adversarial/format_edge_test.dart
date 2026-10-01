import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/shared/format.dart';

void main() {
  setUp(() => MoneyFormat.configure(symbol: '₦', code: 'NGN', locale: 'en_NG'));

  test('money survives nulls, negatives, huge and non-finite values', () {
    expect(formatMoney(null), isNotEmpty);
    expect(formatMoney(-5), contains('5'));
    expect(formatMoney(1e15), isNotEmpty);
    expect(() => formatMoney(double.nan), returnsNormally);
    expect(() => formatMoney(double.infinity), returnsNormally);
    expect(formatMoneyCompact(999999999999), isNotEmpty);
    expect(formatMoneyCompact(0), contains('0'));
    expect(formatNumber(null), '0');
  });

  test('percent delta never divides by zero', () {
    expect(percentDelta(0, 0), anyOf(isNull, 0));
    expect(percentDelta(5, 0), isNull);
    expect(percentDelta(50, 100), -50);
    expect(percentDelta(-10, 10), -200);
    expect(() => formatPercentDelta(double.nan), returnsNormally);
  });

  test('date helpers tolerate garbage', () {
    for (final bad in [
      null,
      '',
      'garbage',
      '2026-13-45',
      '12/09/2026',
      '2026-09-12T99:99:99Z',
    ]) {
      expect(() => formatDate(bad), returnsNormally, reason: '$bad');
      expect(() => formatDateTime(bad), returnsNormally, reason: '$bad');
      expect(() => formatDayLabel(bad), returnsNormally, reason: '$bad');
      expect(() => formatDateShort(bad), returnsNormally, reason: '$bad');
      expect(() => formatDayMonth(bad), returnsNormally, reason: '$bad');
      expect(() => yearOf(bad), returnsNormally, reason: '$bad');
    }
    expect(yearOf('nope'), isNull);
  });

  test('relative time handles the future and the distant past', () {
    final now = DateTime(2026, 10, 1, 12);
    expect(
      () => formatRelativeTime(now.add(const Duration(hours: 3)), now: now),
      returnsNormally,
    );
    expect(
      formatRelativeTime(now.subtract(const Duration(days: 4000)), now: now),
      isNotEmpty,
    );
    expect(formatRelativeTime(now, now: now), isNotEmpty);
  });

  test(
    'an unknown locale from remote config falls back instead of throwing',
    () {
      expect(
        () =>
            MoneyFormat.configure(locale: 'xx_YY', symbol: 'GH₵', code: 'GHS'),
        returnsNormally,
      );
      expect(formatMoney(1234.5), contains('GH₵'));
      expect(
        () => MoneyFormat.configure(symbol: '', locale: ''),
        returnsNormally,
      );
    },
  );
}
