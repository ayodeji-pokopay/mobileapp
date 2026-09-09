import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/widgets/pokopay_logo.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import 'app_config.dart';
import 'app_config_provider.dart';

/// Wraps the whole app. Shows a blocking "update required" screen when the
/// installed version is below the backend minimum, and a maintenance strip
/// when the backend flags maintenance. Otherwise renders [child] untouched.
class AppGate extends ConsumerWidget {
  const AppGate({
    super.key,
    required this.child,
    required this.updateTitle,
    required this.updateBody,
    required this.updateButton,
    required this.maintenanceTitle,
  });

  final Widget child;
  final String updateTitle;
  final String updateBody;
  final String updateButton;
  final String maintenanceTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider).asData?.value;
    final version = ref.watch(packageInfoProvider).asData?.value.version;
    if (config == null || version == null) return child;

    if (config.requiresUpdate(version)) {
      return _UpdateRequired(
        config: config,
        title: updateTitle,
        body: updateBody,
        button: updateButton,
      );
    }

    if (!config.maintenance.enabled) return child;
    return Column(
      children: [
        _MaintenanceStrip(
          title: maintenanceTitle,
          message: config.maintenance.message,
        ),
        Expanded(child: child),
      ],
    );
  }
}

class _MaintenanceStrip extends StatelessWidget {
  const _MaintenanceStrip({required this.title, this.message});
  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Material(
      color: AppColors.warningBg,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, top + 8, 16, 10),
        child: Row(
          children: [
            const Icon(
              LucideIcons.wrench,
              size: 18,
              color: AppColors.warningText,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppText.body(
                      size: 13,
                      weight: FontWeight.w600,
                      color: AppColors.warningText,
                    ),
                  ),
                  if (message != null && message!.isNotEmpty)
                    Text(
                      message!,
                      style: AppText.body(
                        size: 12,
                        color: AppColors.warningText,
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

class _UpdateRequired extends StatelessWidget {
  const _UpdateRequired({
    required this.config,
    required this.title,
    required this.body,
    required this.button,
  });
  final AppConfig config;
  final String title;
  final String body;
  final String button;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.canvas,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: PokopayMark()),
              const SizedBox(height: 40),
              Text(title, style: AppText.display(size: 32)),
              const SizedBox(height: 12),
              Text(
                body,
                style: AppText.body(size: 16, color: AppColors.textSecondary),
              ),
              if ((config.latestVersion ?? '').isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'v${config.latestVersion}',
                  style: AppText.body(size: 13, color: AppColors.textTertiary),
                ),
              ],
              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: config.storeUrl == null
                    ? null
                    : () => launchUrl(
                        Uri.parse(config.storeUrl!),
                        mode: LaunchMode.externalApplication,
                      ),
                icon: const Icon(LucideIcons.download, size: 18),
                label: Text(button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
