/// Shapes from `/api/v1/merchant/reports/transactions/*` (Insights &
/// Alerts API). Amounts are naira; rates are percentages; buckets are
/// already in Africa/Lagos time.
library;

double _d(Object? v) => v is num ? v.toDouble() : double.tryParse('$v') ?? 0;
int _i(Object? v) => v is num ? v.toInt() : int.tryParse('$v') ?? 0;
double? _dn(Object? v) => v == null ? null : _d(v);

class PeriodSummary {
  const PeriodSummary({
    required this.total,
    required this.approved,
    required this.declined,
    required this.failed,
    required this.totalAmount,
    required this.approvedAmount,
    required this.approvedFees,
    required this.avgDurationMs,
    required this.approvalRate,
  });
  final int total;
  final int approved;
  final int declined;
  final int failed;
  final double totalAmount;
  final double approvedAmount;
  final double approvedFees;
  final double avgDurationMs;

  /// Percent, e.g. 83.33
  final double approvalRate;

  factory PeriodSummary.fromJson(Map<String, dynamic> j) => PeriodSummary(
    total: _i(j['total']),
    approved: _i(j['approved']),
    declined: _i(j['declined']),
    failed: _i(j['failed']),
    totalAmount: _d(j['totalAmount']),
    approvedAmount: _d(j['approvedAmount']),
    approvedFees: _d(j['approvedFees']),
    avgDurationMs: _d(j['avgDurationMs']),
    approvalRate: _d(j['approvalRate']),
  );
}

class SummaryComparison {
  const SummaryComparison({
    required this.current,
    required this.previous,
    this.countChangePct,
    this.approvedChangePct,
    this.approvedAmountChangePct,
  });
  final PeriodSummary current;
  final PeriodSummary? previous;

  /// null when the previous window has no data ("new").
  final double? countChangePct;
  final double? approvedChangePct;
  final double? approvedAmountChangePct;

  factory SummaryComparison.fromJson(Map<String, dynamic> j) =>
      SummaryComparison(
        current: PeriodSummary.fromJson(
          (j['current'] as Map?)?.cast<String, dynamic>() ?? const {},
        ),
        previous: j['previous'] is Map
            ? PeriodSummary.fromJson((j['previous'] as Map).cast())
            : null,
        countChangePct: _dn(j['countChangePct']),
        approvedChangePct: _dn(j['approvedChangePct']),
        approvedAmountChangePct: _dn(j['approvedAmountChangePct']),
      );
}

class WeekdayBucket {
  const WeekdayBucket({
    required this.isoDayOfWeek,
    required this.count,
    required this.approved,
    required this.approvedAmount,
  });

  /// 1 = Monday … 7 = Sunday
  final int isoDayOfWeek;
  final int count;
  final int approved;
  final double approvedAmount;

  factory WeekdayBucket.fromJson(Map<String, dynamic> j) => WeekdayBucket(
    isoDayOfWeek: _i(j['isoDayOfWeek']),
    count: _i(j['count']),
    approved: _i(j['approved']),
    approvedAmount: _d(j['approvedAmount']),
  );
}

class HourBucket {
  const HourBucket({
    required this.hour,
    required this.count,
    required this.approved,
  });
  final int hour;
  final int count;
  final int approved;

  factory HourBucket.fromJson(Map<String, dynamic> j) => HourBucket(
    hour: _i(j['hour']),
    count: _i(j['count']),
    approved: _i(j['approved']),
  );
}

class TerminalBucket {
  const TerminalBucket({
    required this.tid,
    required this.count,
    required this.approved,
    required this.approvalRate,
    required this.approvedAmount,
  });
  final String tid;
  final int count;
  final int approved;
  final double approvalRate;
  final double approvedAmount;

  factory TerminalBucket.fromJson(Map<String, dynamic> j) => TerminalBucket(
    tid: j['tid']?.toString() ?? '',
    count: _i(j['count']),
    approved: _i(j['approved']),
    approvalRate: _d(j['approvalRate']),
    approvedAmount: _d(j['approvedAmount']),
  );
}

class DayPoint {
  const DayPoint({
    required this.date,
    required this.count,
    required this.approved,
    required this.approvedAmount,
  });
  final DateTime date;
  final int count;
  final int approved;
  final double approvedAmount;

  factory DayPoint.fromJson(Map<String, dynamic> j) => DayPoint(
    date: DateTime.tryParse(j['date']?.toString() ?? '') ?? DateTime(1970),
    count: _i(j['count']),
    approved: _i(j['approved']),
    approvedAmount: _d(j['approvedAmount']),
  );
}

List<T> parseList<T>(Object? data, T Function(Map<String, dynamic>) f) => [
  if (data is List)
    for (final e in data)
      if (e is Map) f(e.cast<String, dynamic>()),
];
