import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/merchant_models.dart';
import 'package:pokopay/core/api/models/transaction_models.dart';
import 'package:pokopay/core/api/models/wallet_models.dart';
import 'package:pokopay/features/merchant/presentation/merchant_providers.dart';
import 'package:pokopay/shared/format.dart';

void main() {
  group('WalletResponse', () {
    test('converts kobo balances to naira and derives the cycle', () {
      final w = WalletResponse.fromJson({
        'availableBalance': 6482,
        'ledgerBalance': 6482,
        'pendingSettlement': 150,
        'settlementType': 'T_PLUS_0',
        'frozen': false,
        'status': 'ACTIVE',
        'accountNumber': '****9683',
      });
      expect(w.availableNaira, 64.82);
      expect(w.pendingNaira, 1.5);
      expect(w.cycle, 'T0');
      expect(w.isFrozen, isFalse);
    });

    test('frozen flag or status marks the wallet frozen', () {
      expect(WalletResponse.fromJson({'frozen': true}).isFrozen, isTrue);
      expect(WalletResponse.fromJson({'status': 'FROZEN'}).isFrozen, isTrue);
    });
  });

  group('TransactionResponse', () {
    final t = TransactionResponse.fromJson({
      'transactionRef': '2POK0005-232651-625223232651',
      'tid': '2POK0005',
      'transactionType': 'purchase',
      'panMasked': '539983******1456',
      'cardScheme': 'MASTERCARD',
      'cardType': 'debit',
      'amount': 2.0,
      'feeAmount': 0.0,
      'status': 'APPROVED',
      'initiatedAt': '2026-09-09T22:27:05.723911Z',
      'completedAt': '2026-09-09T22:27:07.315490Z',
    });

    test('maps backend names to app getters', () {
      expect(t.reference, '2POK0005-232651-625223232651');
      expect(t.maskedPan, '539983******1456');
      expect(t.last4, '1456');
      expect(t.fee, 0);
      expect(t.netAmount, 2.0);
      expect(t.transactionDate, '2026-09-09T22:27:07.315490Z');
      expect(t.scheme, 'MASTERCARD');
    });

    test('splits STAN and RRN out of the reference', () {
      expect(t.stan, '232651');
      expect(t.rrn, '625223232651');
      expect(
        TransactionResponse.fromJson({'transactionRef': 'x'}).stan,
        isNull,
      );
    });
  });

  group('CardSchemeSummary', () {
    test('accepts totalSales/fees as well as totalAmount/totalFees', () {
      final a = CardSchemeSummary.fromJson({
        'cardScheme': 'MASTERCARD',
        'totalSales': 22.0,
        'fees': 0,
      });
      final b = CardSchemeSummary.fromJson({
        'cardScheme': 'VISA',
        'totalAmount': 5.0,
        'totalFees': 1,
      });
      expect(a.amount, 22.0);
      expect(a.feeAmount, 0);
      expect(b.amount, 5.0);
      expect(b.feeAmount, 1);
    });
  });

  group('dailyTotals', () {
    test('sums approved amounts per day, oldest first', () {
      final now = DateTime.now();
      String iso(int daysAgo, {int hour = 10}) => DateTime(
        now.year,
        now.month,
        now.day - daysAgo,
        hour,
      ).toUtc().toIso8601String();
      final txns = [
        TransactionResponse(amount: 5, status: 'APPROVED', completedAt: iso(0)),
        TransactionResponse(amount: 3, status: 'APPROVED', completedAt: iso(0)),
        TransactionResponse(amount: 9, status: 'FAILED', completedAt: iso(0)),
        TransactionResponse(amount: 4, status: 'APPROVED', completedAt: iso(2)),
        TransactionResponse(
          amount: 1,
          status: 'APPROVED',
          completedAt: iso(10),
        ),
      ];
      final totals = dailyTotals(txns, 7);
      expect(totals.length, 7);
      expect(totals.last, 8);
      expect(totals[4], 4);
      expect(totals.reduce((a, b) => a + b), 12);
    });
  });

  test('percentDelta handles zero and null baselines', () {
    expect(percentDelta(22, 5), closeTo(340, 0.001));
    expect(percentDelta(0, 0), 0);
    expect(percentDelta(5, 0), isNull);
    expect(percentDelta(null, 5), isNull);
  });
}
