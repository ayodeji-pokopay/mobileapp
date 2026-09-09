import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/info_row.dart';
import '../../../shared/widgets/list_card.dart';
import '../../../shared/widgets/back_scaffold.dart';
import '../../auth/presentation/auth_controller.dart';

class PersonalInfoScreen extends ConsumerWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).user;
    return BackScaffold(
      title: 'Personal\ninformation',
      titleSize: 36,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
        children: [
          ListCard(children: [
            InfoRow(label: 'First name', value: user?.firstName),
            InfoRow(label: 'Last name', value: user?.lastName),
            InfoRow(label: 'E-mail', value: user?.email),
            InfoRow(label: 'Role', value: user?.role),
            InfoRow(
              label: 'Email verified',
              value: (user?.emailVerified ?? false) ? 'Yes' : 'No',
            ),
            InfoRow(label: 'User ID', value: user?.id, mono: true),
          ]),
        ],
      ),
    );
  }
}
