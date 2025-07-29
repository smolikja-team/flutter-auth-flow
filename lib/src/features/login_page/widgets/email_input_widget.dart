import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/text_styles/text_styles.dart';
import 'package:flutter_auth_flow/src/core/widgets/title_text_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/providers/login_provider.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/auth_text_field_widget.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailInputWidget extends ConsumerWidget {
  const EmailInputWidget(this.dep, {super.key});

  final FlutterAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TitleTextWidget(
          text: context.l10n.auth_label_email,
          style: TextStyles.titleSmall.copyWith(color: dep.colorOnPrimary),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        const SizedBox(height: 8.0),
        AuthTextFieldWidget(
          dep,
          isPassword: false,
          hintText: context.l10n.auth_hint_email,
          onChanged: ref.read(loginProvider.notifier).setEmail,
        ),
      ],
    );
  }
}
