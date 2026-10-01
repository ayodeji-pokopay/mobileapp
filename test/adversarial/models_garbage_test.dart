import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/auth_models.dart';
import 'package:pokopay/core/api/models/business_models.dart';
import 'package:pokopay/core/api/models/insights_models.dart';
import 'package:pokopay/core/api/models/merchant_models.dart';
import 'package:pokopay/core/api/models/staff_models.dart';
import 'package:pokopay/core/api/models/transaction_models.dart';
import 'package:pokopay/core/api/models/wallet_models.dart';
import 'package:pokopay/features/auth/data/auth_repository.dart';

void main() {
  group('backend sends the wrong JSON types', () {
    test('numbers as strings in a transaction', () {
      expect(
        () => TransactionResponse.fromJson({
          'amount': '5.00',
          'feeAmount': '0.02',
          'durationMs': '12',
        }),
        returnsNormally,
        reason: 'a stringly-typed amount must not crash the feed',
      );
    });
    test('null where a list is expected', () {
      expect(
        () => PageTransactionResponse.fromJson({'content': null}),
        returnsNormally,
      );
      expect(
        () => UserInfoResponse.fromJson({
          'permissions': null,
          'tenants': null,
          'terminalIds': null,
        }),
        returnsNormally,
      );
      expect(
        () =>
            NotificationItem.fromJson({'evidence': 'not a map', 'read': 'yes'}),
        returnsNormally,
      );
      expect(
        () => TerminalResponse.fromJson({
          'healthReasons': null,
          'batteryPercent': '82',
          'signal': 3.7,
        }),
        returnsNormally,
      );
    });
    test('wallet balances as strings or missing', () {
      expect(
        () => WalletResponse.fromJson({'availableBalance': '648200'}),
        returnsNormally,
      );
      expect(() => WalletResponse.fromJson(const {}), returnsNormally);
    });
    test('summary with nested garbage', () {
      expect(
        () => MerchantSettlementSummary.fromJson({
          'todaySettlement': {'amount': 'abc'},
        }),
        returnsNormally,
      );
    });
    test('plain-class parsers are already lenient', () {
      expect(
        () => SessionInfo.fromJson({
          'active': 'true',
          'current': 1,
          'createdAt': 12345,
        }),
        returnsNormally,
      );
      expect(
        () => StaffMember.fromJson({
          'permissions': 'VIEW_SALES',
          'terminalIds': 'x',
          'active': 'no',
        }),
        returnsNormally,
      );
      expect(
        () => SummaryComparison.fromJson({
          'current': null,
          'previous': 'x',
          'countChangePct': 'n/a',
        }),
        returnsNormally,
      );
      expect(
        () => DayPoint.fromJson({'date': 42, 'approvedAmount': '1,000'}),
        returnsNormally,
      );
      expect(parseList('not a list', WeekdayBucket.fromJson), isEmpty);
      expect(
        parseList([
          1,
          'two',
          null,
          {'isoDayOfWeek': 3},
        ], WeekdayBucket.fromJson).length,
        1,
      );
    });
  });

  group('derived fields on odd values', () {
    test('masked PAN shorter than 4 and odd references', () {
      final t = TransactionResponse(
        panMasked: '12',
        transactionRef: 'no-dashes-here',
      );
      expect(() => t.last4, returnsNormally);
      expect(t.stan, isNull);
      expect(t.rrn, isNull);
      final w = TransactionResponse(transactionRef: '----');
      expect(() => w.stan, returnsNormally);
    });
    test('net amount with fee but no amount', () {
      expect(TransactionResponse(feeAmount: 2).netAmount, isNull);
    });
  });
}
