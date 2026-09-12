import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/api/models/business_models.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/format.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/pills.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../dashboard/presentation/dashboard_providers.dart';
import 'rename_terminal_sheet.dart';

/// Friendly copy for a backend `healthReasons` code.
String terminalReasonLabel(String code, AppLocalizations l10n) =>
    switch (code.toUpperCase()) {
      'LOW_BATTERY' => l10n.terminalReasonLowBattery,
      'PRINTER_OUT_OF_PAPER' => l10n.terminalReasonOutOfPaper,
      'PRINTER_COVER_OPEN' => l10n.terminalReasonCoverOpen,
      'PRINTER_OVERHEAT' => l10n.terminalReasonOverheat,
      'PRINTER_ERROR' => l10n.terminalReasonPrinterError,
      'WEAK_SIGNAL' => l10n.terminalReasonWeakSignal,
      'STALE' => l10n.terminalReasonStale,
      'OFFLINE' => l10n.terminalReasonOffline,
      _ => code,
    };

String printerStatusLabel(String? status, AppLocalizations l10n) =>
    switch ((status ?? '').toUpperCase()) {
      'OK' => l10n.printerStatusOk,
      'OUT_OF_PAPER' => l10n.terminalReasonOutOfPaper,
      'COVER_OPEN' => l10n.terminalReasonCoverOpen,
      'OVERHEAT' => l10n.terminalReasonOverheat,
      'ERROR' => l10n.terminalReasonPrinterError,
      _ => l10n.commonDash,
    };

String connectionLabel(String? type, AppLocalizations l10n) =>
    switch ((type ?? '').toUpperCase()) {
      'WIFI' => l10n.connectionWifi,
      'ETHERNET' => l10n.connectionEthernet,
      'SIM' => l10n.connectionSim,
      'OFFLINE' => l10n.terminalOffline,
      _ => l10n.commonDash,
    };

Future<void> showTerminalDetailSheet(BuildContext context, TerminalResponse t) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.canvas,
    builder: (_) => TerminalDetailSheet(t: t),
  );
}

class TerminalDetailSheet extends ConsumerWidget {
  const TerminalDetailSheet({super.key, required this.t});
  final TerminalResponse t;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final canRename = ref.watch(authControllerProvider).canManageTerminals;
    final bottom = MediaQuery.paddingOf(context).bottom;
    final h = terminalHealth(t);
    final (tone, verdict) = switch (h) {
      TerminalHealth.online => (PillTone.success, l10n.terminalHealthy),
      TerminalHealth.degraded => (PillTone.warning, l10n.terminalDegraded),
      TerminalHealth.idle => (PillTone.warning, l10n.terminalIdle),
      TerminalHealth.offline => (PillTone.danger, l10n.terminalOffline),
    };
    final seen = DateTime.tryParse(t.lastHeartbeat ?? '');
    final name = (t.label ?? '').isNotEmpty
        ? t.label!
        : (t.model ?? '').isNotEmpty
        ? t.model!
        : l10n.storesTerminal;
    final battery = t.batteryPercent;
    final hasTelemetry =
        battery != null || t.connectionType != null || t.printerStatus != null;

    Widget row(IconData icon, String label, String value, {Widget? trailing}) =>
        ListRow(
          leading: Icon(icon, size: 20, color: AppColors.textSecondary),
          title: label,
          subtitle: value,
          chevron: false,
          trailing: trailing,
        );

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 16 + bottom),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderStrong,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(child: Text(name, style: AppText.money(size: 18))),
                StatusPill(label: verdict, tone: tone),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              [
                if ((t.tid ?? '').isNotEmpty) l10n.tidLabel(t.tid!),
                if ((t.serialNumber ?? '').isNotEmpty)
                  l10n.terminalSerial(t.serialNumber!),
              ].join(' · '),
              style: AppText.body(size: 13, color: AppColors.textTertiary),
            ),
            if (t.healthReasons.isNotEmpty && h != TerminalHealth.online) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final r in t.healthReasons)
                    StatusPill(
                      label: terminalReasonLabel(r, l10n),
                      tone: h == TerminalHealth.offline
                          ? PillTone.danger
                          : PillTone.warning,
                    ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            ListCard(
              children: [
                row(
                  LucideIcons.clock,
                  l10n.terminalLastSeenLabel,
                  seen == null
                      ? l10n.terminalNeverSeen
                      : formatRelativeTime(seen),
                ),
                if (battery != null)
                  row(
                    battery > 60
                        ? LucideIcons.batteryFull
                        : battery > 25
                        ? LucideIcons.batteryMedium
                        : LucideIcons.batteryLow,
                    l10n.terminalBattery,
                    '$battery%',
                    trailing: t.charging == true
                        ? Icon(
                            LucideIcons.zap,
                            size: 18,
                            color: AppColors.primary,
                          )
                        : null,
                  ),
                if (t.connectionType != null)
                  row(
                    switch ((t.connectionType ?? '').toUpperCase()) {
                      'WIFI' => LucideIcons.wifi,
                      'ETHERNET' => LucideIcons.cable,
                      'SIM' => LucideIcons.signal,
                      _ => LucideIcons.wifiOff,
                    },
                    l10n.terminalConnection,
                    connectionLabel(t.connectionType, l10n),
                    trailing: t.signal == null
                        ? null
                        : _SignalBars(level: t.signal!),
                  ),
                if (t.printerStatus != null)
                  row(
                    LucideIcons.printer,
                    l10n.terminalPrinter,
                    printerStatusLabel(t.printerStatus, l10n),
                  ),
                if ((t.appVersion ?? '').isNotEmpty)
                  row(
                    LucideIcons.smartphone,
                    l10n.terminalAppVersion,
                    t.appVersion!,
                  ),
              ],
            ),
            if (!hasTelemetry) ...[
              const SizedBox(height: 10),
              Text(
                l10n.terminalNoTelemetry,
                style: AppText.body(size: 12.5, color: AppColors.textTertiary),
              ),
            ],
            if (canRename) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  showRenameTerminalSheet(context, t);
                },
                icon: const Icon(LucideIcons.pencil, size: 18),
                label: Text(l10n.terminalRename),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SignalBars extends StatelessWidget {
  const _SignalBars({required this.level});
  final int level; // 0..4

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$level/4',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 1; i <= 4; i++)
            Container(
              width: 4,
              height: 4.0 + i * 3,
              margin: const EdgeInsets.only(left: 2),
              decoration: BoxDecoration(
                color: i <= level ? AppColors.primary : AppColors.borderStrong,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
        ],
      ),
    );
  }
}
