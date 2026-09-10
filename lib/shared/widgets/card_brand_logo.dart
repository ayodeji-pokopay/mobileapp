import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

/// Vector card-scheme marks drawn in code so no image assets are needed.
/// Falls back to a two-letter tile for unknown schemes.
class CardBrandLogo extends StatelessWidget {
  const CardBrandLogo({super.key, required this.scheme, this.size = 42});

  final String? scheme;
  final double size;

  @override
  Widget build(BuildContext context) {
    final s = (scheme ?? '').toUpperCase();
    final Widget mark;
    if (s.startsWith('MASTER')) {
      mark = _Mastercard(size: size);
    } else if (s.startsWith('VISA')) {
      mark = _WordMark('VISA', const Color(0xFF1A1F71), size, italic: true);
    } else if (s.startsWith('VERVE')) {
      mark = _Verve(size: size);
    } else if (s.startsWith('AMEX') || s.contains('AMERICAN')) {
      mark = _Amex(size: size);
    } else {
      final abbr = s.isEmpty ? '··' : s.substring(0, s.length >= 2 ? 2 : 1);
      mark = Text(
        abbr,
        style: AppText.money(size: size * 0.28, color: AppColors.textBody),
      );
    }
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(size * 0.28),
        border: Border.all(color: AppColors.hairline),
      ),
      child: mark,
    );
  }
}

class _Mastercard extends StatelessWidget {
  const _Mastercard({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    final r = size * 0.24;
    return SizedBox(
      width: r * 3.2,
      height: r * 2,
      child: Stack(
        children: [
          Positioned(left: 0, child: _circle(r, const Color(0xFFEB001B))),
          Positioned(
            left: r * 1.2,
            child: _circle(r, const Color(0xFFF79E1B).withValues(alpha: 0.92)),
          ),
        ],
      ),
    );
  }

  Widget _circle(double r, Color c) => Container(
    width: r * 2,
    height: r * 2,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );
}

class _WordMark extends StatelessWidget {
  const _WordMark(this.text, this.color, this.size, {this.italic = false});
  final String text;
  final Color color;
  final double size;
  final bool italic;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Helvetica Neue',
        fontSize: size * 0.3,
        fontWeight: FontWeight.w900,
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        color: color,
        letterSpacing: -0.5,
        height: 1,
      ),
    );
  }
}

class _Verve extends StatelessWidget {
  const _Verve({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size * 0.18,
          height: size * 0.18,
          decoration: const BoxDecoration(
            color: Color(0xFF00A651),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: size * 0.05),
        Text(
          'verve',
          style: TextStyle(
            fontSize: size * 0.28,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFE31E24),
            letterSpacing: -0.6,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _Amex extends StatelessWidget {
  const _Amex({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.1,
        vertical: size * 0.08,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF2E77BC),
        borderRadius: BorderRadius.circular(size * 0.08),
      ),
      child: Text(
        'AMEX',
        style: TextStyle(
          fontSize: size * 0.2,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 0.2,
          height: 1,
        ),
      ),
    );
  }
}
