import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/l10n/locale_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text.dart';
import '../../../core/theme/theme_mode_controller.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/pills.dart';
import '../../../shared/widgets/section_label.dart';

Future<void> showPreferencesSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: AppColors.canvas,
    builder: (_) => const PreferencesSheet(),
  );
}

/// Appearance (system / light / dark) and language.
class PreferencesSheet extends ConsumerWidget {
  const PreferencesSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final mode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final bottom = MediaQuery.paddingOf(context).bottom;

    Widget check(bool on) => Icon(
      on ? LucideIcons.circleCheck : LucideIcons.circle,
      size: 20,
      color: on ? AppColors.primary : AppColors.textDisabled,
    );

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
          Text(l10n.settingsPreferences, style: AppText.money(size: 17)),
          const SizedBox(height: 18),
          SectionLabel(l10n.prefAppearance, color: AppColors.textSecondary),
          ListCard(
            children: [
              for (final (m, label, icon) in [
                (
                  ThemeMode.system,
                  l10n.prefAppearanceSystem,
                  LucideIcons.smartphone,
                ),
                (ThemeMode.light, l10n.prefAppearanceLight, LucideIcons.sun),
                (ThemeMode.dark, l10n.prefAppearanceDark, LucideIcons.moon),
              ])
                ListRow(
                  leading: IconBubble(
                    icon: icon,
                    tone: mode == m ? PillTone.success : PillTone.neutral,
                    size: 36,
                  ),
                  title: label,
                  chevron: false,
                  trailing: check(mode == m),
                  onTap: () => ref.read(themeModeProvider.notifier).set(m),
                ),
            ],
          ),
          const SizedBox(height: 20),
          SectionLabel(l10n.prefLanguage, color: AppColors.textSecondary),
          ListCard(
            children: [
              ListRow(
                title: l10n.prefLanguageSystem,
                subtitle: l10n.prefLanguageSystemHint,
                chevron: false,
                trailing: check(locale == null),
                onTap: () => ref.read(localeProvider.notifier).set(null),
              ),
              for (final lang in AppLanguage.all)
                ListRow(
                  title: lang.nativeName,
                  subtitle: lang.englishName == lang.nativeName
                      ? null
                      : lang.englishName,
                  chevron: false,
                  trailing: check(locale?.languageCode == lang.code),
                  onTap: () =>
                      ref.read(localeProvider.notifier).set(lang.locale),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.prefLanguageNote,
            style: AppText.body(
              size: 12,
              color: AppColors.textTertiary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
