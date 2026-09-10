import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/info_row.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../../l10n/generated/app_localizations.dart';

class PersonalInfoScreen extends ConsumerWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(authControllerProvider).user;
    return BackScaffold(
      title: l10n.personalTitle,
      titleSize: 28,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          ListCard(
            children: [
              InfoRow(label: l10n.personalFirstName, value: user?.firstName),
              InfoRow(label: l10n.personalLastName, value: user?.lastName),
              InfoRow(label: l10n.personalEmail, value: user?.email),
              InfoRow(label: l10n.personalRole, value: user?.role),
              InfoRow(
                label: l10n.personalEmailVerified,
                value: (user?.emailVerified ?? false)
                    ? l10n.commonYes
                    : l10n.commonNo,
              ),
              InfoRow(label: l10n.personalUserId, value: user?.id, mono: true),
            ],
          ),
        ],
      ),
    );
  }
}
