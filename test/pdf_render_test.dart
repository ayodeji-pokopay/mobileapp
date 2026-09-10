import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokopay/core/api/models/merchant_models.dart';
import 'package:pokopay/core/api/models/transaction_models.dart';
import 'package:pokopay/l10n/generated/app_localizations.dart';
import 'package:pokopay/shared/pdf/pokopay_pdf.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('receipt and report PDFs build with brand assets', () async {
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final t = TransactionResponse.fromJson({
      'transactionRef': '2POK0005-030058-625303030058',
      'tid': '2POK0005',
      'transactionType': 'purchase',
      'panMasked': '539983******6344',
      'cardScheme': 'MASTERCARD',
      'cardBank': 'Guaranty Trust Bank',
      'cardType': 'debit',
      'amount': 1.0,
      'feeAmount': 0.0,
      'status': 'APPROVED',
      'responseCode': '00',
      'responseCodeDescription': 'Approved',
      'completedAt': '2026-09-10T02:01:07Z',
    });
    final receipt = await buildReceiptPdf(
      t: t, business: 'POKOPAY PILOT', l10n: l10n, statusLabel: 'Approved', approved: true);
    final report = await buildSalesReportPdf(
      r: MerchantSalesReportResponse.fromJson({
        'mid': '2POK00000000003', 'businessName': 'POKOPAY PILOT',
        'merchantAddress': '40 westcote Road', 'merchantPhone': '08135895236',
        'merchantEmail': 'awonowoayodeji@gmail.com',
        'startDate': '2026-09-03', 'endDate': '2026-09-10',
        'totalSales': 25.0, 'totalTransactionCount': 15, 'totalFees': 0, 'netAmount': 25.0,
        'totalSettled': 0, 'pendingSettlement': 25.0, 'settlementCount': 0,
        'previousPeriod': {'startDate': '2026-08-26', 'endDate': '2026-09-02', 'totalSales': 5.0, 'totalTransactionCount': 3},
        'cardSchemeBreakdown': [{'cardScheme': 'MASTERCARD', 'totalSales': 25.0, 'transactionCount': 15, 'averageTransactionValue': 1.67, 'fees': 0}],
        'terminalBreakdown': [{'tid': '2POK0001', 'totalSales': 15.0, 'transactionCount': 8, 'fees': 0}, {'tid': '2POK0005', 'totalSales': 10.0, 'transactionCount': 7, 'fees': 0}],
      }),
      business: 'POKOPAY PILOT', l10n: l10n, periodLabel: 'Last week');
    expect(receipt.length, greaterThan(5000));
    expect(report.length, greaterThan(5000));
    final out = Platform.environment['PDF_OUT'];
    if (out != null) {
      File('$out/receipt.pdf').writeAsBytesSync(receipt);
      File('$out/report.pdf').writeAsBytesSync(report);
    }
  });
}
