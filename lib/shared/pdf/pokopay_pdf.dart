import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../core/api/models/merchant_models.dart';
import '../../core/api/models/transaction_models.dart';
import '../../l10n/generated/app_localizations.dart';
import '../format.dart';

/// Brand palette for PDFs, mirroring AppColors.
class PdfBrand {
  PdfBrand._();
  static const navy = PdfColor.fromInt(0xFF0C2545);
  static const navyMuted = PdfColor.fromInt(0xFF1A3A5F);
  static const green = PdfColor.fromInt(0xFF317E3D);
  static const greenSoft = PdfColor.fromInt(0xFFE8F5EA);
  static const canvas = PdfColor.fromInt(0xFFF0EFEC);
  static const ink = PdfColor.fromInt(0xFF1F2937);
  static const muted = PdfColor.fromInt(0xFF4B5563);
  static const faint = PdfColor.fromInt(0xFF6B7280);
  static const line = PdfColor.fromInt(0xFFE5E3E0);
  static const danger = PdfColor.fromInt(0xFFDC2626);
  static const white = PdfColors.white;
}

/// Fonts and logo loaded once per document.
class PdfAssets {
  PdfAssets._(
    this.display,
    this.displayHeavy,
    this.body,
    this.bodyStrong,
    this.symbol,
    this.wordmark,
  );

  final pw.Font display;
  final pw.Font displayHeavy;
  final pw.Font body;
  final pw.Font bodyStrong;
  final pw.MemoryImage symbol;
  final pw.MemoryImage wordmark;

  static PdfAssets? _cached;

  static Future<PdfAssets> load() async {
    if (_cached != null) return _cached!;
    Future<pw.Font> font(String path) async =>
        pw.Font.ttf(await rootBundle.load(path));
    Future<pw.MemoryImage> image(String path) async =>
        pw.MemoryImage((await rootBundle.load(path)).buffer.asUint8List());
    _cached = PdfAssets._(
      await font('assets/fonts/Montserrat-Bold.ttf'),
      await font('assets/fonts/Montserrat-ExtraBold.ttf'),
      await font('assets/fonts/DMSans-Regular.ttf'),
      await font('assets/fonts/DMSans-SemiBold.ttf'),
      await image('assets/branding/pokopay_symbol.png'),
      await image('assets/branding/pokopay_wordmark.png'),
    );
    return _cached!;
  }

  pw.TextStyle h(
    double size, {
    PdfColor color = PdfBrand.navy,
    bool heavy = false,
  }) => pw.TextStyle(
    font: heavy ? displayHeavy : display,
    fontSize: size,
    color: color,
  );
  pw.TextStyle t(
    double size, {
    PdfColor color = PdfBrand.ink,
    bool strong = false,
  }) => pw.TextStyle(
    font: strong ? bodyStrong : body,
    fontSize: size,
    color: color,
  );

  /// Style for a value cell: Montserrat when the text carries the Naira
  /// sign (DM Sans lacks it), DM Sans otherwise.
  pw.TextStyle v(
    String text,
    double size, {
    PdfColor color = PdfBrand.ink,
    bool strong = true,
  }) => text.contains('₦')
      ? h(size, color: color)
      : t(size, color: color, strong: strong);

  pw.TextStyle label({PdfColor color = PdfBrand.faint}) => pw.TextStyle(
    font: bodyStrong,
    fontSize: 8,
    color: color,
    letterSpacing: 0.8,
  );
}

// ── Shared building blocks ─────────────────────────────────────────────

pw.Widget _header(
  PdfAssets a, {
  required String title,
  required String subtitle,
  String? badge,
}) {
  return pw.Container(
    padding: const pw.EdgeInsets.fromLTRB(26, 22, 26, 22),
    decoration: const pw.BoxDecoration(
      color: PdfBrand.navy,
      borderRadius: pw.BorderRadius.all(pw.Radius.circular(14)),
    ),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Container(
          width: 40,
          height: 40,
          padding: const pw.EdgeInsets.all(6),
          decoration: const pw.BoxDecoration(
            color: PdfBrand.white,
            borderRadius: pw.BorderRadius.all(pw.Radius.circular(10)),
          ),
          child: pw.Image(a.symbol, fit: pw.BoxFit.contain),
        ),
        pw.SizedBox(width: 12),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'pokopay',
                style: a.h(15, color: PdfBrand.white, heavy: true),
              ),
              pw.SizedBox(height: 6),
              pw.Text(
                title,
                style: a.h(20, color: PdfBrand.white, heavy: true),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                subtitle,
                style: a.t(9.5, color: PdfColor.fromInt(0xFFB8C4D6)),
              ),
            ],
          ),
        ),
        if (badge != null)
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const pw.BoxDecoration(
              color: PdfBrand.green,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(9)),
            ),
            child: pw.Text(
              badge,
              style: a.t(9, color: PdfBrand.white, strong: true),
            ),
          ),
      ],
    ),
  );
}

pw.Widget _sectionTitle(PdfAssets a, String text) => pw.Padding(
  padding: const pw.EdgeInsets.only(top: 18, bottom: 8),
  child: pw.Row(
    children: [
      pw.Container(width: 4, height: 12, color: PdfBrand.green),
      pw.SizedBox(width: 8),
      pw.Text(text.toUpperCase(), style: a.label(color: PdfBrand.muted)),
    ],
  ),
);

pw.Widget _tile(
  PdfAssets a,
  String label,
  String value, {
  PdfColor color = PdfBrand.navy,
  PdfColor bg = PdfBrand.white,
}) {
  return pw.Expanded(
    child: pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: bg,
        border: pw.Border.all(color: PdfBrand.line, width: 0.8),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label.toUpperCase(), style: a.label()),
          pw.SizedBox(height: 6),
          pw.Text(value, style: a.h(15, color: color, heavy: true)),
        ],
      ),
    ),
  );
}

pw.Widget _kv(PdfAssets a, String k, String? v, {bool mono = false}) {
  if (v == null || v.isEmpty) return pw.SizedBox();
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 6),
    decoration: const pw.BoxDecoration(
      border: pw.Border(
        bottom: pw.BorderSide(color: PdfBrand.line, width: 0.6),
      ),
    ),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 150,
          child: pw.Text(k, style: a.t(9.5, color: PdfBrand.muted)),
        ),
        pw.Expanded(
          child: pw.Text(
            v,
            style: a.v(v, 9.5, color: PdfBrand.navy, strong: !mono),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

pw.Widget _table(
  PdfAssets a,
  List<String> head,
  List<List<String>> rows, {
  List<int> flex = const [],
  List<pw.TextAlign> align = const [],
}) {
  pw.TextAlign al(int i) => i < align.length
      ? align[i]
      : (i == 0 ? pw.TextAlign.left : pw.TextAlign.right);
  int fx(int i) => i < flex.length ? flex[i] : 1;
  pw.Widget cell(String s, int i, {bool header = false, PdfColor? color}) =>
      pw.Expanded(
        flex: fx(i),
        child: pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          child: pw.Text(
            s,
            textAlign: al(i),
            style: header
                ? a.label(color: PdfBrand.muted)
                : a.v(s, 9.5, color: color ?? PdfBrand.ink, strong: false),
          ),
        ),
      );
  return pw.Container(
    decoration: pw.BoxDecoration(
      border: pw.Border.all(color: PdfBrand.line, width: 0.8),
      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
    ),
    child: pw.Column(
      children: [
        pw.Container(
          decoration: const pw.BoxDecoration(
            color: PdfBrand.canvas,
            borderRadius: pw.BorderRadius.vertical(top: pw.Radius.circular(10)),
          ),
          child: pw.Row(
            children: [
              for (var i = 0; i < head.length; i++)
                cell(head[i].toUpperCase(), i, header: true),
            ],
          ),
        ),
        for (var r = 0; r < rows.length; r++)
          pw.Container(
            decoration: pw.BoxDecoration(
              color: r.isOdd ? PdfColor.fromInt(0xFFFAFAF9) : PdfBrand.white,
              border: const pw.Border(
                top: pw.BorderSide(color: PdfBrand.line, width: 0.6),
              ),
            ),
            child: pw.Row(
              children: [
                for (var i = 0; i < rows[r].length; i++) cell(rows[r][i], i),
              ],
            ),
          ),
      ],
    ),
  );
}

pw.Widget _footer(PdfAssets a, pw.Context ctx, String generated) =>
    pw.Container(
      padding: const pw.EdgeInsets.only(top: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfBrand.line, width: 0.6)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(generated, style: a.t(8, color: PdfBrand.faint)),
          pw.Text(
            '${ctx.pageNumber} / ${ctx.pagesCount}',
            style: a.t(8, color: PdfBrand.faint),
          ),
        ],
      ),
    );

// ── Sales report ───────────────────────────────────────────────────────

Future<Uint8List> buildSalesReportPdf({
  required MerchantSalesReportResponse r,
  required String business,
  required AppLocalizations l10n,
  required String periodLabel,
}) async {
  final a = await PdfAssets.load();
  final doc = pw.Document(title: 'Pokopay sales report', author: 'Pokopay');
  final range = [
    if ((r.startDate ?? '').isNotEmpty) formatDateShort(r.startDate),
    if ((r.endDate ?? '').isNotEmpty) formatDateShort(r.endDate),
  ].join(' – ');
  final generated =
      'Generated ${formatDateShort(DateTime.now().toIso8601String())} ${formatTime(DateTime.now())} · Pokopay Merchant';
  final schemes = [...r.cardSchemeBreakdown]
    ..sort((x, y) => (y.amount ?? 0).compareTo(x.amount ?? 0));
  final terminals = [...r.terminalBreakdown]
    ..sort((x, y) => (y.totalSales ?? 0).compareTo(x.totalSales ?? 0));
  final prev = r.previousPeriod;
  final delta = percentDelta(r.totalSales, prev?.totalSales);

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(32, 30, 32, 28),
      footer: (ctx) => _footer(a, ctx, generated),
      build: (ctx) => [
        _header(
          a,
          title: 'Sales report',
          subtitle: '$business · $periodLabel · $range',
          badge: periodLabel,
        ),
        pw.SizedBox(height: 16),
        pw.Row(
          children: [
            _tile(
              a,
              'Total sales',
              formatMoney(r.totalSales),
              bg: PdfBrand.greenSoft,
              color: PdfBrand.green,
            ),
            pw.SizedBox(width: 10),
            _tile(a, 'Transactions', formatNumber(r.totalTransactionCount)),
            pw.SizedBox(width: 10),
            _tile(
              a,
              'Fees',
              formatMoney(r.totalFees),
              color: (r.totalFees ?? 0) > 0 ? PdfBrand.danger : PdfBrand.navy,
            ),
            pw.SizedBox(width: 10),
            _tile(a, 'Net amount', formatMoney(r.netAmount)),
          ],
        ),
        if (prev != null) ...[
          pw.SizedBox(height: 10),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: const pw.BoxDecoration(
              color: PdfBrand.canvas,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
            ),
            child: pw.Row(
              children: [
                pw.Text(
                  delta == null
                      ? '—'
                      : '${delta >= 0 ? '+' : ''}${delta.toStringAsFixed(1)}%',
                  style: a.h(
                    11,
                    color: (delta ?? 0) >= 0 ? PdfBrand.green : PdfBrand.danger,
                    heavy: true,
                  ),
                ),
                pw.SizedBox(width: 8),
                pw.Text(
                  'vs previous period (${formatDateShort(prev.startDate)} – ${formatDateShort(prev.endDate)}): ',
                  style: a.t(9, color: PdfBrand.muted),
                ),
                pw.Text(
                  formatMoney(prev.totalSales),
                  style: a.h(9, color: PdfBrand.muted),
                ),
                pw.Text(
                  ', ${formatNumber(prev.totalTransactionCount)} transactions',
                  style: a.t(9, color: PdfBrand.muted),
                ),
              ],
            ),
          ),
        ],
        _sectionTitle(a, 'Merchant'),
        _kv(a, 'Business', r.businessName ?? r.merchantName ?? business),
        _kv(a, 'Merchant ID', r.mid, mono: true),
        _kv(a, 'Address', r.merchantAddress),
        _kv(a, 'Phone', r.merchantPhone),
        _kv(a, 'Email', r.merchantEmail),
        _sectionTitle(a, 'Settlement'),
        pw.Row(
          children: [
            _tile(a, 'Settled', formatMoney(r.totalSettled)),
            pw.SizedBox(width: 10),
            _tile(a, 'Pending settlement', formatMoney(r.pendingSettlement)),
            pw.SizedBox(width: 10),
            _tile(a, 'Settlements', formatNumber(r.settlementCount)),
          ],
        ),
        if (schemes.isNotEmpty) ...[
          _sectionTitle(a, 'Sales by card scheme'),
          _table(
            a,
            ['Card scheme', 'Total sales', 'Transactions', 'Avg value', 'Fees'],
            [
              for (final s in schemes)
                [
                  _title(s.cardScheme ?? ''),
                  formatMoney(s.amount),
                  formatNumber(s.transactionCount),
                  formatMoney(
                    s.averageTransactionValue ??
                        ((s.transactionCount ?? 0) == 0
                            ? 0
                            : (s.amount ?? 0) / s.transactionCount!),
                  ),
                  formatMoney(s.feeAmount),
                ],
            ],
            flex: const [3, 2, 2, 2, 2],
          ),
        ],
        if (terminals.isNotEmpty) ...[
          _sectionTitle(a, 'Sales by terminal'),
          _table(
            a,
            ['Terminal', 'Total sales', 'Transactions', 'Fees'],
            [
              for (final t in terminals)
                [
                  [
                    (t.terminalLocation ?? '').isNotEmpty
                        ? t.terminalLocation!
                        : 'TID',
                    t.tid ?? '',
                  ].join(' '),
                  formatMoney(t.totalSales),
                  formatNumber(t.transactionCount),
                  formatMoney(t.fees),
                ],
            ],
            flex: const [3, 2, 2, 2],
          ),
        ],
        pw.SizedBox(height: 18),
        pw.Center(
          child: pw.Text(
            'This report was generated by the Pokopay Merchant app.',
            style: a.t(8, color: PdfBrand.faint),
          ),
        ),
      ],
    ),
  );
  return doc.save();
}

// ── Receipt ────────────────────────────────────────────────────────────

Future<Uint8List> buildReceiptPdf({
  required TransactionResponse t,
  required String business,
  required AppLocalizations l10n,
  required String statusLabel,
  required bool approved,
}) async {
  final a = await PdfAssets.load();
  final doc = pw.Document(title: 'Pokopay receipt', author: 'Pokopay');
  final d = DateTime.tryParse(t.transactionDate ?? '')?.toLocal();
  final when = d == null
      ? ''
      : '${formatDateShort(t.transactionDate)} · ${formatTime(d)}';
  final generated =
      'Generated ${formatDateShort(DateTime.now().toIso8601String())} ${formatTime(DateTime.now())} · Pokopay Merchant';
  final scheme = (t.scheme ?? '').toLowerCase();
  final card = scheme.isEmpty
      ? ''
      : '${scheme[0].toUpperCase()}${scheme.substring(1)} ${(t.cardType ?? '').toLowerCase()}'
            .trim();

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a5,
      margin: const pw.EdgeInsets.all(24),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(20),
            decoration: const pw.BoxDecoration(
              color: PdfBrand.navy,
              borderRadius: pw.BorderRadius.all(pw.Radius.circular(14)),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Container(
                      width: 30,
                      height: 30,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfBrand.white,
                        borderRadius: pw.BorderRadius.all(
                          pw.Radius.circular(8),
                        ),
                      ),
                      child: pw.Image(a.symbol, fit: pw.BoxFit.contain),
                    ),
                    pw.SizedBox(width: 8),
                    pw.Text(
                      'pokopay',
                      style: a.h(13, color: PdfBrand.white, heavy: true),
                    ),
                    pw.Spacer(),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: pw.BoxDecoration(
                        color: approved ? PdfBrand.green : PdfBrand.danger,
                        borderRadius: const pw.BorderRadius.all(
                          pw.Radius.circular(9),
                        ),
                      ),
                      child: pw.Text(
                        statusLabel,
                        style: a.t(8.5, color: PdfBrand.white, strong: true),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  l10n.receiptTitle.toUpperCase(),
                  style: a.label(color: PdfColor.fromInt(0xFF9FB0C8)),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  formatMoney(t.amount),
                  style: a.h(26, color: PdfBrand.white, heavy: true),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  [business, when].where((e) => e.isNotEmpty).join(' · '),
                  style: a.t(9, color: PdfColor.fromInt(0xFFB8C4D6)),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 14),
          _kv(
            a,
            l10n.receiptCard,
            [card, t.maskedPan ?? ''].where((e) => e.isNotEmpty).join('  '),
          ),
          _kv(a, l10n.receiptBank, t.cardBank),
          _kv(a, l10n.receiptTerminal, t.tid, mono: true),
          _kv(a, l10n.receiptAmount, formatMoney(t.amount)),
          _kv(a, l10n.receiptFee, t.fee == null ? null : formatMoney(t.fee)),
          _kv(
            a,
            l10n.receiptNet,
            t.netAmount == null ? null : formatMoney(t.netAmount),
          ),
          _kv(a, l10n.receiptReference, t.reference, mono: true),
          _kv(a, l10n.receiptStan, t.stan, mono: true),
          _kv(a, l10n.receiptRrn, t.rrn, mono: true),
          _kv(a, l10n.receiptAuthCode, t.authCode, mono: true),
          _kv(
            a,
            l10n.receiptResponse,
            [
              t.responseCode,
              t.responseCodeDescription,
            ].where((e) => (e ?? '').isNotEmpty).join(' · '),
            mono: true,
          ),
          pw.Spacer(),
          pw.Center(
            child: pw.Text(
              l10n.receiptPoweredBy,
              style: a.t(8, color: PdfBrand.faint),
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Center(
            child: pw.Text(generated, style: a.t(7, color: PdfBrand.faint)),
          ),
        ],
      ),
    ),
  );
  return doc.save();
}

String _title(String s) {
  final l = s.toLowerCase();
  return l.isEmpty ? s : l[0].toUpperCase() + l.substring(1);
}
