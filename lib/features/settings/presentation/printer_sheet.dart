import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/printing/receipt_printer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/pill_tabs.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/section_label.dart';
import '../../merchant/presentation/merchant_providers.dart';

Future<void> showPrinterSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.canvas,
    builder: (_) => const PrinterSheet(),
  );
}

class PrinterSheet extends ConsumerStatefulWidget {
  const PrinterSheet({super.key});

  @override
  ConsumerState<PrinterSheet> createState() => _PrinterSheetState();
}

class _PrinterSheetState extends ConsumerState<PrinterSheet> {
  List<PrinterDevice>? _paired;
  bool _btOff = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = ref.read(receiptPrinterProvider);
    try {
      final on = await p.bluetoothOn();
      final list = on ? await p.paired() : <PrinterDevice>[];
      if (!mounted) return;
      setState(() {
        _btOff = !on;
        _paired = list;
      });
    } catch (_) {
      if (mounted) setState(() => _paired = const []);
    }
  }

  Future<void> _select(PrinterDevice d) async {
    final l10n = AppLocalizations.of(context);
    await ref.read(receiptPrinterProvider).save(d);
    ref.invalidate(printerSettingsProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.printerSelected)));
  }

  Future<void> _test() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(receiptPrinterProvider)
          .printTest(ref.read(businessNameProvider));
      messenger.showSnackBar(SnackBar(content: Text(l10n.printerPrinted)));
    } on PrinterException catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            e.code == 'BLUETOOTH_OFF'
                ? l10n.printerBluetoothOff
                : l10n.printerConnectFailed,
          ),
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
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(printerSettingsProvider).asData?.value;
    final bottom = MediaQuery.paddingOf(context).bottom;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.92,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: EdgeInsets.fromLTRB(20, 12, 20, 24 + bottom),
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
          Text(l10n.printerTitle, style: AppText.money(size: 17)),
          const SizedBox(height: 4),
          Text(
            l10n.printerHint,
            style: AppText.body(size: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 18),
          SectionLabel(l10n.printerPaperWidth, color: AppColors.textSecondary),
          PillTabs(
            items: const ['58 mm', '80 mm'],
            selected: (settings?.paper ?? 58) == 80 ? 1 : 0,
            onChanged: (i) async {
              await ref
                  .read(receiptPrinterProvider)
                  .save(
                    settings?.configured == true
                        ? PrinterDevice(
                            name: settings!.name ?? '',
                            address: settings.address!,
                          )
                        : null,
                    paper: i == 1 ? 80 : 58,
                  );
              ref.invalidate(printerSettingsProvider);
            },
          ),
          const SizedBox(height: 18),
          SectionLabel(l10n.printerPaired, color: AppColors.textSecondary),
          if (_paired == null)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else if (_btOff)
            EmptyState(
              icon: LucideIcons.bluetoothOff,
              title: l10n.printerBluetoothOff,
            )
          else if (_paired!.isEmpty)
            EmptyState(icon: LucideIcons.printer, title: l10n.printerNoPaired)
          else
            ListCard(
              children: [
                for (final d in _paired!)
                  ListRow(
                    leading: IconBubble(
                      icon: LucideIcons.printer,
                      tone: settings?.address == d.address
                          ? PillTone.success
                          : PillTone.neutral,
                    ),
                    title: d.name.isEmpty ? d.address : d.name,
                    subtitle: d.address,
                    chevron: false,
                    trailing: settings?.address == d.address
                        ? Icon(
                            LucideIcons.circleCheck,
                            size: 20,
                            color: AppColors.primary,
                          )
                        : null,
                    onTap: () => _select(d),
                  ),
              ],
            ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: settings?.configured == true && !_busy ? _test : null,
            icon: const Icon(LucideIcons.printer, size: 18),
            label: Text(l10n.printerTest),
          ),
        ],
      ),
    );
  }
}
