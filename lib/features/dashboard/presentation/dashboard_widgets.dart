import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api/models/merchant_models.dart';
import '../../../core/config/app_config_provider.dart';
import '../../../core/lock/app_lock.dart';
import '../../../core/printing/receipt_printer.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/skeleton.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../reports/presentation/send_receipt_sheet.dart';
import '../../reports/presentation/transaction_style.dart';
import '../../settings/presentation/security_screen.dart';
import '../../stores/presentation/terminal_detail_sheet.dart';
import 'dashboard_providers.dart';

// ── Settlement tracker ───────────────────────────────────────────────

enum _Step { none, batched, sent, paid, failed }

class SettlementTracker extends StatelessWidget {
  const SettlementTracker({
    super.key,
    required this.summary,
    required this.onTap,
  });
  final AsyncValue<MerchantSettlementSummary> summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final s = summary.asData?.value;
    final ts = s?.todaySettlement;
    final amount = ts?.amount ?? s?.pendingAmount;
    final status = (ts?.status ?? '').toUpperCase();
    final pending = (s?.pendingAmount ?? 0) > 0;
    final step = switch (status) {
      'NONE' => _Step.none,
      'PENDING' || 'POSTPONED' || 'BATCHED' || 'QUEUED' => _Step.batched,
      'PROCESSING' || 'SENT' || 'IN_TRANSIT' || 'INITIATED' => _Step.sent,
      'SETTLED' || 'COMPLETED' || 'PAID' => _Step.paid,
      'FAILED' || 'REJECTED' => _Step.failed,
      _ =>
        pending ? _Step.batched : ((amount ?? 0) > 0 ? _Step.paid : _Step.none),
    };
    final expected = ts?.expectedDate;
    final settledAt = ts?.settledAt;
    final reason = ts?.failureReason;
    final footer = switch (step) {
      _Step.failed =>
        reason != null && reason.isNotEmpty
            ? reason
            : l10n.settlementStepFailed,
      _Step.paid =>
        settledAt != null && settledAt.isNotEmpty
            ? l10n.settlementPaidAt(_expectedLabel(settledAt, context))
            : l10n.dashboardSettled,
      _Step.none => l10n.settlementStepNone,
      _ when status == 'POSTPONED' => l10n.settlementStepPostponed,
      _ when expected != null && expected.isNotEmpty =>
        l10n.dashboardExpectedBy(_expectedLabel(expected, context)),
      _ => l10n.dashboardPending,
    };
    final reached = switch (step) {
      _Step.none => 0,
      _Step.batched => 1,
      _Step.sent => 2,
      _Step.paid => 3,
      _Step.failed => 1,
    };
    final labels = [
      l10n.settlementStepBatched,
      l10n.settlementStepSent,
      l10n.settlementStepPaid,
    ];

    return SurfaceCard(
      radius: 16,
      padding: const EdgeInsets.all(14),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dashboardTodaysSettlements,
            style: AppText.body(size: 12, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 4),
          if (summary.isLoading)
            const Skeleton(height: 20, width: 90)
          else
            Text(
              summary.hasValue ? formatMoney(amount) : '—',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.money(size: 18),
            ),
          const SizedBox(height: 10),
          for (var i = 0; i < 3; i++)
            _StepRow(
              label: labels[i],
              state: step == _Step.failed && i == 1
                  ? _StepState.failed
                  : i < reached
                  ? _StepState.done
                  : i == reached
                  ? _StepState.current
                  : _StepState.todo,
              last: i == 2,
            ),
          const SizedBox(height: 6),
          Text(
            footer,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppText.body(
              size: 12,
              weight: FontWeight.w500,
              color: step == _Step.failed
                  ? AppColors.danger
                  : step == _Step.paid
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String _expectedLabel(String iso, BuildContext context) {
    final d = DateTime.tryParse(iso);
    if (d == null) return iso;
    final now = DateTime.now();
    final sameDay =
        d.year == now.year && d.month == now.month && d.day == now.day;
    if (sameDay && (d.hour != 0 || d.minute != 0)) return formatTime(d);
    if (sameDay) return AppLocalizations.of(context).commonToday;
    return formatDateShort(iso);
  }
}

enum _StepState { done, current, todo, failed }

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.label,
    required this.state,
    required this.last,
  });
  final String label;
  final _StepState state;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      _StepState.done => AppColors.primary,
      _StepState.current => AppColors.warning,
      _StepState.failed => AppColors.danger,
      _StepState.todo => AppColors.borderStrong,
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state == _StepState.todo ? Colors.transparent : color,
                border: Border.all(color: color, width: 2),
              ),
              child: state == _StepState.done
                  ? const Icon(Icons.check, size: 8, color: Colors.white)
                  : null,
            ),
            if (!last)
              Container(
                width: 2,
                height: 12,
                color: state == _StepState.done
                    ? AppColors.primary
                    : AppColors.borderStrong,
              ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.body(
                size: 12,
                weight: state == _StepState.current
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: state == _StepState.todo
                    ? AppColors.textTertiary
                    : AppColors.textPrimary,
                height: 1.1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Terminal health strip ────────────────────────────────────────────

class TerminalStrip extends ConsumerWidget {
  const TerminalStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authControllerProvider);
    final list = (ref.watch(terminalsProvider).asData?.value ?? const [])
        .where((t) => auth.inScope(t.tid))
        .toList();
    if (list.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final t = list[i];
          final h = terminalHealth(t);
          final (color, status) = switch (h) {
            TerminalHealth.online => (AppColors.primary, l10n.terminalOnline),
            TerminalHealth.degraded => (
              AppColors.warning,
              l10n.terminalDegraded,
            ),
            TerminalHealth.idle => (AppColors.warning, l10n.terminalIdle),
            TerminalHealth.offline => (AppColors.danger, l10n.terminalOffline),
          };
          final reason = t.healthReasons.isEmpty
              ? null
              : terminalReasonLabel(t.healthReasons.first, l10n);
          final text = reason != null && h != TerminalHealth.online
              ? reason
              : status;
          final name = (t.label ?? '').isNotEmpty
              ? t.label!
              : (t.tid ?? t.model ?? l10n.storesTerminal);
          return Semantics(
            button: true,
            label: '$name, $text',
            child: Material(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(999),
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () => showTerminalDetailSheet(context, t),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        name,
                        style: AppText.body(size: 13, weight: FontWeight.w600),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        text,
                        style: AppText.body(
                          size: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Approval warning ─────────────────────────────────────────────────

class ApprovalWarningCard extends ConsumerWidget {
  const ApprovalWarningCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final h = ref.watch(approvalHealthProvider).asData?.value;
    if (h == null || !h.warning) return const SizedBox.shrink();
    final today = (h.todayRate * 100).round();
    final usual = ((h.baselineRate ?? 0) * 100).round();
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SurfaceCard(
        radius: 14,
        padding: const EdgeInsets.all(12),
        color: AppColors.warningBg,
        onTap: () => context.go(AppRoutes.reports),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IconBubble(
              icon: LucideIcons.triangleAlert,
              tone: PillTone.warning,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dashboardApprovalWarningTitle,
                    style: AppText.body(
                      size: 14,
                      weight: FontWeight.w600,
                      color: AppColors.warningText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.dashboardApprovalWarningBody(today, usual),
                    style: AppText.body(
                      size: 12.5,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  if (h.topReason != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      l10n.dashboardApprovalTopReason(h.topReason!),
                      style: AppText.body(
                        size: 12.5,
                        weight: FontWeight.w600,
                        color: AppColors.textBody,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Quick actions ────────────────────────────────────────────────────

class QuickActionsRow extends ConsumerWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final last = ref.watch(lastReceiptProvider);
    final config = ref.watch(appConfigProvider).asData?.value;
    final links = config?.features.paymentLinks ?? false;
    final phone = config?.support.phone;

    Future<void> printLast() async {
      if (last == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.dashboardNoReceiptsYet)));
        return;
      }
      final messenger = ScaffoldMessenger.of(context);
      try {
        final style = transactionStyle(last, l10n);
        await ref
            .read(receiptPrinterProvider)
            .printReceipt(
              last,
              business: ref.read(businessNameProvider),
              statusLabel: style.statusLabel,
            );
        messenger.showSnackBar(SnackBar(content: Text(l10n.printerPrinted)));
      } on PrinterException catch (e) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(switch (e.code) {
              'BLUETOOTH_OFF' => l10n.printerBluetoothOff,
              'NOT_CONFIGURED' => l10n.printerNone,
              _ => l10n.printerConnectFailed,
            }),
            backgroundColor: AppColors.danger,
          ),
        );
      } catch (_) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.printerConnectFailed),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }

    final canShare = ref.watch(authControllerProvider).canShareReceipts;
    final actions = <(IconData, String, VoidCallback)>[
      if (canShare)
        (
          LucideIcons.send,
          l10n.dashboardQuickSendReceipt,
          () {
            if (last == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.dashboardNoReceiptsYet)),
              );
            } else {
              showSendReceiptSheet(context, last);
            }
          },
        ),
      if (canShare)
        (LucideIcons.printer, l10n.dashboardQuickPrintLast, printLast),
      if (links)
        (
          LucideIcons.link,
          l10n.dashboardQuickPaymentLink,
          () => context.go(AppRoutes.reports),
        ),
      (
        LucideIcons.headset,
        l10n.dashboardQuickCallSupport,
        () async {
          final uri = phone != null && phone.isNotEmpty
              ? Uri(scheme: 'tel', path: phone.replaceAll(' ', ''))
              : Uri(
                  scheme: 'mailto',
                  path: config?.support.email ?? 'support@pokopayng.com',
                );
          if (!await launchUrl(uri) && context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.sendReceiptAppMissing)));
          }
        },
      ),
    ];

    return Row(
      children: [
        for (final (i, a) in actions.indexed) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            child: _QuickAction(icon: a.$1, label: a.$2, onTap: a.$3),
          ),
        ],
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: AppColors.primary),
                const SizedBox(height: 6),
                Text(
                  label,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.body(
                    size: 11,
                    weight: FontWeight.w600,
                    height: 1.15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Goal ring ────────────────────────────────────────────────────────

class GoalRing extends StatelessWidget {
  const GoalRing({
    super.key,
    required this.done,
    required this.target,
    required this.onTap,
    this.size = 56,
  });
  final double done;
  final double? target;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = target;
    final progress = t == null || t <= 0 ? 0.0 : (done / t).clamp(0.0, 1.0);
    return Semantics(
      button: true,
      label: t == null
          ? l10n.dashboardGoalSet
          : l10n.dashboardGoalProgress(
              formatMoneyCompact(done),
              formatMoneyCompact(t),
            ),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _RingPainter(
              progress: progress,
              track: Colors.white.withValues(alpha: 0.18),
              fill: progress >= 1
                  ? AppColors.brandGreen
                  : AppColors.primaryBright,
            ),
            child: Center(
              child: t == null
                  ? const Icon(
                      LucideIcons.target,
                      size: 18,
                      color: Colors.white,
                    )
                  : Text(
                      '${(progress * 100).round()}%',
                      style: AppText.money(size: 12, color: Colors.white),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.track,
    required this.fill,
  });
  final double progress;
  final Color track;
  final Color fill;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = 5.0;
    final r = rect.deflate(stroke / 2);
    canvas.drawArc(
      r,
      0,
      math.pi * 2,
      false,
      Paint()
        ..color = track
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke,
    );
    if (progress > 0) {
      canvas.drawArc(
        r,
        -math.pi / 2,
        math.pi * 2 * progress,
        false,
        Paint()
          ..color = fill
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = stroke,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.fill != fill;
}

Future<void> showGoalSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _GoalSheet(),
  );
}

class _GoalSheet extends ConsumerStatefulWidget {
  const _GoalSheet();
  @override
  ConsumerState<_GoalSheet> createState() => _GoalSheetState();
}

class _GoalSheetState extends ConsumerState<_GoalSheet> {
  late final _daily = TextEditingController(
    text: _fmt(ref.read(salesGoalProvider).daily),
  );
  late final _monthly = TextEditingController(
    text: _fmt(ref.read(salesGoalProvider).monthly),
  );

  static String _fmt(double? v) =>
      v == null ? '' : NumberFormat('#,##0', 'en').format(v);
  static double? _parse(String s) =>
      double.tryParse(s.replaceAll(RegExp(r'[^\d.]'), ''));

  @override
  void dispose() {
    _daily.dispose();
    _monthly.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    final bottom = MediaQuery.paddingOf(context).bottom;
    InputDecoration deco(String label) => InputDecoration(
      labelText: label,
      prefixText: '${MoneyFormat.symbol} ',
      fillColor: AppColors.canvas,
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        16 + (inset > 0 ? inset : bottom),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.hairline,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(l10n.goalSheetTitle, style: AppText.money(size: 17)),
          const SizedBox(height: 4),
          Text(
            l10n.goalSheetHint,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _daily,
            keyboardType: TextInputType.number,
            style: AppText.money(size: 18),
            decoration: deco(l10n.goalDaily),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _monthly,
            keyboardType: TextInputType.number,
            style: AppText.money(size: 18),
            decoration: deco(l10n.goalMonthly),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(salesGoalProvider.notifier)
                  .save(
                    daily: _parse(_daily.text),
                    monthly: _parse(_monthly.text),
                  );
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Text(l10n.commonSave),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(salesGoalProvider.notifier).save();
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Text(l10n.goalClear),
          ),
        ],
      ),
    );
  }
}

// ── Set-PIN prompt and device warning ────────────────────────────────

class SetPinCard extends ConsumerWidget {
  const SetPinCard({super.key, required this.onDismiss});
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconBubble(icon: LucideIcons.lockKeyhole, tone: PillTone.info),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.lockSetPinPromptTitle,
                  style: AppText.body(size: 14, weight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.lockSetPinPromptBody,
                  style: AppText.body(
                    size: 12.5,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        minimumSize: const Size(0, 34),
                      ),
                      onPressed: () async {
                        final pin = await showSetPinSheet(context);
                        if (pin != null)
                          await ref.read(appLockProvider.notifier).setPin(pin);
                      },
                      child: Text(l10n.lockSetPinPromptAction),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textTertiary,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        minimumSize: const Size(0, 34),
                      ),
                      onPressed: onDismiss,
                      child: Text(l10n.lockNotNow),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeviceWarningBanner extends StatelessWidget {
  const DeviceWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SurfaceCard(
      radius: 14,
      padding: const EdgeInsets.all(12),
      color: AppColors.dangerBg,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IconBubble(
            icon: LucideIcons.shieldAlert,
            tone: PillTone.danger,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.deviceCompromisedTitle,
                  style: AppText.body(
                    size: 14,
                    weight: FontWeight.w600,
                    color: AppColors.danger,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.deviceCompromisedBody,
                  style: AppText.body(
                    size: 12.5,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Activity filter chips ────────────────────────────────────────────

class ActivityFilterChips extends ConsumerWidget {
  const ActivityFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final f = ref.watch(activityFilterProvider);
    return PillTabs(
      scrollable: true,
      inactiveColor: AppColors.surface,
      inactiveTextColor: AppColors.textBody,
      items: [
        l10n.activityFilterAll,
        l10n.activityFilterApproved,
        l10n.activityFilterDeclined,
        l10n.activityFilterReversed,
      ],
      selected: f.index,
      onChanged: (i) => ref
          .read(activityFilterProvider.notifier)
          .set(ActivityFilter.values[i]),
    );
  }
}
