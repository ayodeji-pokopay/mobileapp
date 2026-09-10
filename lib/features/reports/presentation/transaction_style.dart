import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/transaction_models.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/pills.dart';

class TransactionStyle {
  const TransactionStyle({
    required this.title,
    required this.statusLabel,
    required this.icon,
    required this.tone,
    required this.inbound,
    required this.muted,
  });
  final String title;
  final String statusLabel;
  final IconData icon;
  final PillTone tone;

  /// Money moving to the merchant.
  final bool inbound;

  /// Reversed / declined amounts are shown struck-through and excluded
  /// from takings.
  final bool muted;
}

/// One place that decides how a transaction type + status looks.
TransactionStyle transactionStyle(
  TransactionResponse t,
  AppLocalizations l10n,
) {
  final type = (t.type ?? 'PURCHASE').toUpperCase();
  final status = (t.status ?? 'APPROVED').toUpperCase();

  if (status == 'REVERSED') {
    return TransactionStyle(
      title: l10n.activityReversal,
      statusLabel: l10n.txnReversed,
      icon: LucideIcons.undo2,
      tone: PillTone.reversed,
      inbound: false,
      muted: true,
    );
  }
  if (status == 'DECLINED') {
    return TransactionStyle(
      title: l10n.activityDeclined,
      statusLabel: l10n.txnDeclined,
      icon: LucideIcons.circleX,
      tone: PillTone.danger,
      inbound: false,
      muted: true,
    );
  }
  if (type == 'REFUND' || status == 'REFUNDED') {
    return TransactionStyle(
      title: l10n.activityRefund,
      statusLabel: l10n.txnRefunded,
      icon: LucideIcons.rotateCcw,
      tone: PillTone.danger,
      inbound: false,
      muted: false,
    );
  }
  if (type == 'REVERSAL') {
    return TransactionStyle(
      title: l10n.activityReversal,
      statusLabel: l10n.txnReversed,
      icon: LucideIcons.undo2,
      tone: PillTone.reversed,
      inbound: false,
      muted: true,
    );
  }
  return TransactionStyle(
    title: l10n.activityCardPayment,
    statusLabel: l10n.txnApproved,
    icon: LucideIcons.creditCard,
    tone: PillTone.success,
    inbound: true,
    muted: false,
  );
}

String schemeAbbr(String? scheme) {
  final s = (scheme ?? '').toUpperCase();
  if (s.startsWith('MASTER')) return 'MC';
  if (s.startsWith('VISA')) return 'VS';
  if (s.startsWith('VERVE')) return 'VE';
  if (s.isEmpty) return '··';
  return s.length >= 2 ? s.substring(0, 2) : s;
}

String schemeName(String? scheme, AppLocalizations l10n) {
  final s = (scheme ?? '').trim();
  if (s.isEmpty) return l10n.salesOther;
  final lower = s.toLowerCase();
  return lower[0].toUpperCase() + lower.substring(1);
}

String last4(String? maskedPan) {
  final p = maskedPan ?? '';
  return p.length >= 4 ? p.substring(p.length - 4) : p;
}
