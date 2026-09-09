import 'package:flutter/material.dart';

import '../../core/theme/app_text.dart';
import '../../l10n/generated/app_localizations.dart';

/// Full wordmark image asset.
class PokopayLogo extends StatelessWidget {
  const PokopayLogo({super.key, this.height = 72});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/branding/pokopay_wordmark.png',
      height: height,
      fit: BoxFit.contain,
    );
  }
}

/// Symbol-only image asset.
class PokopaySymbol extends StatelessWidget {
  const PokopaySymbol({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/branding/pokopay_symbol.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}

/// Symbol + lowercase "pokopay" text, as used on the login screen.
class PokopayMark extends StatelessWidget {
  const PokopayMark({super.key, this.symbolSize = 36, this.fontSize = 26});

  final double symbolSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PokopaySymbol(size: symbolSize),
        const SizedBox(width: 10),
        Text(
          'pokopay',
          style: AppText.display(
            size: fontSize,
            letterSpacing: -fontSize * 0.02,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class PokopayTagline extends StatelessWidget {
  const PokopayTagline({super.key, this.size = 11});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context).tagline,
      style: AppText.tagline(size: size),
    );
  }
}
