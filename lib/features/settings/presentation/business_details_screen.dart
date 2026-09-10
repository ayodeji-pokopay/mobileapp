import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/config/app_config_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../shared/widgets/async_slot.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/info_row.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/section_label.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../merchant/presentation/merchant_providers.dart';
import '../../../l10n/generated/app_localizations.dart';

class BusinessDetailsScreen extends ConsumerWidget {
  const BusinessDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authControllerProvider);
    final profile = ref.watch(merchantProfileProvider);
    final mid = auth.mid;
    final supportEmail =
        ref.watch(appConfigProvider).asData?.value.support.email ??
        'support@pokopayng.com';

    return BackScaffold(
      title: l10n.storeInfoTitle,
      titleSize: 28,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(merchantProfileProvider);
          await ref.read(merchantProfileProvider.future);
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            if ((mid ?? '').isEmpty)
              EmptyState(
                icon: LucideIcons.triangleAlert,
                title: l10n.commonNoMerchantContext,
                subtitle: l10n.commonSignInAgain,
              )
            else
              AsyncSlot<Map<String, dynamic>>(
                value: profile,
                loadingHeight: 320,
                onRetry: () => ref.invalidate(merchantProfileProvider),
                data: (m) => _Details(m: m),
              ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    l10n.storeUpdatePrompt,
                    textAlign: TextAlign.center,
                    style: AppText.body(
                      size: 14,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.storeReachUs(supportEmail)),
                        ),
                      );
                    },
                    child: Text(
                      l10n.storeContactUs,
                      style: AppText.body(
                        size: 16,
                        weight: FontWeight.w600,
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({required this.m});
  final Map<String, dynamic> m;

  String? _s(String key) {
    final v = m[key];
    if (v == null) return null;
    final str = v.toString();
    return str.isEmpty ? null : str;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = _s('status');
    final approved =
        (m['approved'] as bool? ?? false) ||
        (status ?? '').toUpperCase() == 'ACTIVE' ||
        (status ?? '').toUpperCase() == 'APPROVED';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                _s('merchantName') ?? l10n.storeDefaultName,
                style: AppText.money(size: 18),
              ),
            ),
            _StatusChip(
              label:
                  status ?? (approved ? l10n.statusActive : l10n.statusPending),
              ok: approved,
            ),
          ],
        ),
        const SizedBox(height: 20),
        SectionLabel(l10n.storeDetails, uppercase: true),
        ListCard(
          children: [
            InfoRow(label: l10n.storeName, value: _s('merchantName')),
            InfoRow(
              label: l10n.storeMerchantId,
              value: _s('mid'),
              mono: true,
              copyable: true,
            ),
            InfoRow(
              label: l10n.storeAccountCode,
              value: _s('accountCode'),
              mono: true,
            ),
            InfoRow(label: l10n.storeMcc, value: _s('mcc')),
            InfoRow(
              label: l10n.storeAddress,
              value: [
                _s('merchantAddress'),
                _s('lga'),
                _s('state'),
                _s('country'),
              ].whereType<String>().join(', '),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SectionLabel(l10n.storeContact, uppercase: true),
        ListCard(
          children: [
            InfoRow(label: l10n.storeContactName, value: _s('contactName')),
            InfoRow(label: l10n.personalEmail, value: _s('email')),
            InfoRow(label: l10n.storePhone, value: _s('contactPhone')),
            InfoRow(label: l10n.storeUserType, value: _s('userType')),
          ],
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.ok});
  final String label;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    final lower = label.toLowerCase();
    final text = lower[0].toUpperCase() + lower.substring(1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ok ? AppColors.primaryLight : AppColors.warningBg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            ok ? LucideIcons.circleCheck : LucideIcons.clock,
            size: 13,
            color: ok ? AppColors.primary : AppColors.warningText,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: AppText.body(
              size: 12,
              weight: FontWeight.w600,
              color: ok ? AppColors.primary : AppColors.warningText,
            ),
          ),
        ],
      ),
    );
  }
}
