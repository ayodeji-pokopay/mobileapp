import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

/// Smooth line with a soft area fill and an emphasised last point.
class Sparkline extends StatelessWidget {
  const Sparkline({
    super.key,
    required this.values,
    this.height = 36,
    this.color,
  });

  final List<double> values;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? AppColors.primary;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _SparklinePainter(values, color)),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter(this.values, this.color);
  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final data = values.length < 2 ? [0.0, ...values, 0.0] : values;
    final max = data.fold<double>(0, math.max);
    final min = 0.0;
    final range = (max - min) == 0 ? 1.0 : (max - min);
    final dx = size.width / (data.length - 1);
    final pad = 3.0;
    Offset pt(int i) => Offset(
      i * dx,
      size.height - pad - ((data[i] - min) / range) * (size.height - pad * 2),
    );

    final line = Path()..moveTo(pt(0).dx, pt(0).dy);
    for (var i = 1; i < data.length; i++) {
      final p0 = pt(i - 1);
      final p1 = pt(i);
      final cx = (p0.dx + p1.dx) / 2;
      line.cubicTo(cx, p0.dy, cx, p1.dy, p1.dx, p1.dy);
    }
    final area = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      area,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      line,
      Paint()
        ..color = max == 0 ? AppColors.borderStrong : color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    final last = pt(data.length - 1);
    canvas.drawCircle(last, 4.5, Paint()..color = AppColors.surface);
    canvas.drawCircle(
      last,
      3,
      Paint()..color = max == 0 ? AppColors.borderStrong : color,
    );
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.values != values || old.color != color;
}

/// Rounded bars with the best value highlighted, faint gridlines, and
/// axis labels drawn from the same scale.
class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
    required this.values,
    required this.xLabels,
    required this.yFormat,
    this.height = 120,
  });

  final List<double> values;

  /// Labels for the first, middle, and last bar.
  final List<String> xLabels;
  final String Function(double) yFormat;
  final double height;

  @override
  Widget build(BuildContext context) {
    final max = values.fold<double>(0, math.max);
    return Column(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: CustomPaint(
            painter: _BarPainter(
              values: values,
              max: max,
              labels: <double>[max, max / 2, 0.0].map(yFormat).toList(),
              labelStyle: AppText.body(size: 12, color: AppColors.textTertiary),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 44),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final l in xLabels)
                Text(
                  l,
                  style: AppText.body(size: 12, color: AppColors.textTertiary),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BarPainter extends CustomPainter {
  _BarPainter({
    required this.values,
    required this.max,
    required this.labels,
    required this.labelStyle,
  });
  final List<double> values;
  final double max;
  final List<String> labels;
  final TextStyle labelStyle;

  @override
  void paint(Canvas canvas, Size size) {
    const axisW = 44.0;
    final plot = Rect.fromLTWH(axisW, 4, size.width - axisW, size.height - 8);
    final grid = Paint()
      ..color = AppColors.surfaceAlt
      ..strokeWidth = 1;
    for (var i = 0; i < 3; i++) {
      final y = plot.top + plot.height * i / 2;
      canvas.drawLine(Offset(plot.left, y), Offset(plot.right, y), grid);
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: axisW - 6);
      tp.paint(canvas, Offset(0, y - tp.height / 2));
    }
    if (values.isEmpty) return;
    final n = values.length;
    final slot = plot.width / n;
    final barW = math.max(2.0, math.min(slot * 0.62, 18.0));
    final best = values.indexOf(max);
    for (var i = 0; i < n; i++) {
      final h = max == 0 ? 2.0 : math.max(2.0, values[i] / max * plot.height);
      final x = plot.left + slot * i + (slot - barW) / 2;
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, plot.bottom - h, barW, h),
        Radius.circular(barW / 2),
      );
      final isBest = i == best && max > 0;
      canvas.drawRRect(
        rect,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isBest
                ? [AppColors.primaryBright, AppColors.primary]
                : [AppColors.navyMuted, AppColors.navy],
          ).createShader(rect.outerRect),
      );
    }
  }

  @override
  bool shouldRepaint(_BarPainter old) => old.values != values || old.max != max;
}
