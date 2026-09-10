import '../../core/api/models/transaction_models.dart';

/// Pure aggregation over a window of transactions. Kept free of Flutter
/// so it is trivial to unit-test.
class InsightsStats {
  const InsightsStats({
    required this.totalSales,
    required this.count,
    required this.approvedCount,
    required this.averageTicket,
    required this.approvalRate,
    required this.byHour,
    required this.byWeekday,
    required this.byDay,
    required this.byTerminal,
    required this.thisWeek,
    required this.lastWeek,
    required this.monthToDate,
    required this.monthCount,
    required this.bestDay,
    required this.bestDayAmount,
    required this.topTerminal,
    required this.topTerminalAmount,
  });

  final double totalSales;
  final int count;
  final int approvedCount;
  final double averageTicket;
  final double approvalRate;

  /// 24 entries, Lagos/local hour → approved amount.
  final List<double> byHour;

  /// 7 entries, Monday first.
  final List<double> byWeekday;

  /// Oldest first, one per day of the window.
  final List<double> byDay;
  final Map<String, double> byTerminal;
  final double thisWeek;
  final double lastWeek;
  final double monthToDate;
  final int monthCount;
  final DateTime? bestDay;
  final double bestDayAmount;
  final String? topTerminal;
  final double topTerminalAmount;

  int get peakHour {
    var best = 0;
    for (var h = 1; h < 24; h++) {
      if (byHour[h] > byHour[best]) best = h;
    }
    return best;
  }

  /// 1 = Monday … 7 = Sunday
  int get peakWeekday {
    var best = 0;
    for (var d = 1; d < 7; d++) {
      if (byWeekday[d] > byWeekday[best]) best = d;
    }
    return best + 1;
  }

  double? get weekOnWeek {
    if (lastWeek == 0) return thisWeek == 0 ? 0 : null;
    return (thisWeek - lastWeek) / lastWeek * 100;
  }

  bool get isEmpty => count == 0;

  static InsightsStats compute(
    List<TransactionResponse> txns,
    int days, {
    DateTime? now,
  }) {
    final today = now ?? DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);
    final windowStart = startOfToday.subtract(Duration(days: days - 1));
    final weekStart = startOfToday.subtract(Duration(days: today.weekday - 1));
    final lastWeekStart = weekStart.subtract(const Duration(days: 7));
    final monthStart = DateTime(today.year, today.month, 1);

    final byHour = List<double>.filled(24, 0);
    final byWeekday = List<double>.filled(7, 0);
    final byDay = List<double>.filled(days, 0);
    final byTerminal = <String, double>{};
    var total = 0.0, approved = 0, thisWeek = 0.0, lastWeek = 0.0;
    var mtd = 0.0, monthCount = 0;
    final dayTotals = <DateTime, double>{};

    for (final t in txns) {
      final d = DateTime.tryParse(t.transactionDate ?? '')?.toLocal();
      if (d == null) continue;
      final ok = (t.status ?? '').toUpperCase() == 'APPROVED';
      if (!ok) continue;
      final amt = (t.amount ?? 0).toDouble();
      total += amt;
      approved++;
      byHour[d.hour] += amt;
      byWeekday[d.weekday - 1] += amt;
      final dayKey = DateTime(d.year, d.month, d.day);
      final i = dayKey.difference(windowStart).inDays;
      if (i >= 0 && i < days) byDay[i] += amt;
      dayTotals[dayKey] = (dayTotals[dayKey] ?? 0) + amt;
      if ((t.tid ?? '').isNotEmpty) {
        byTerminal[t.tid!] = (byTerminal[t.tid!] ?? 0) + amt;
      }
      if (!dayKey.isBefore(weekStart)) {
        thisWeek += amt;
      } else if (!dayKey.isBefore(lastWeekStart)) {
        lastWeek += amt;
      }
      if (!dayKey.isBefore(monthStart)) {
        mtd += amt;
        monthCount++;
      }
    }

    DateTime? bestDay;
    var bestAmt = 0.0;
    dayTotals.forEach((k, v) {
      if (v > bestAmt) {
        bestAmt = v;
        bestDay = k;
      }
    });
    String? topTid;
    var topAmt = 0.0;
    byTerminal.forEach((k, v) {
      if (v > topAmt) {
        topAmt = v;
        topTid = k;
      }
    });

    return InsightsStats(
      totalSales: total,
      count: txns.length,
      approvedCount: approved,
      averageTicket: approved == 0 ? 0 : total / approved,
      approvalRate: txns.isEmpty ? 0 : approved / txns.length,
      byHour: byHour,
      byWeekday: byWeekday,
      byDay: byDay,
      byTerminal: byTerminal,
      thisWeek: thisWeek,
      lastWeek: lastWeek,
      monthToDate: mtd,
      monthCount: monthCount,
      bestDay: bestDay,
      bestDayAmount: bestAmt,
      topTerminal: topTid,
      topTerminalAmount: topAmt,
    );
  }
}
