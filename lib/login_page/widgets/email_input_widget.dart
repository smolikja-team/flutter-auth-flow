import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/providers/login_provider.dart';
import 'package:firebase_auth_flow/login_page/widgets/auth_text_field_widget.dart';
import 'package:firebase_auth_flow/login_page/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailInputWidget extends ConsumerWidget {
  const EmailInputWidget(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TitleTextWidget(
          text: context.l10n.auth_label_email,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: dep.onPrimary),
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
