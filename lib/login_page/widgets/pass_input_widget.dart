import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/widgets/auth_text_field_widget.dart';
import 'package:firebase_auth_flow/login_page/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PassInputWidget extends ConsumerWidget {
  const PassInputWidget(this.dep, {required this.validation, super.key});

  final FirebaseAuthFlowDependencies dep;
  final bool validation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = validation
        ? context.l10n.auth_label_password_again
        : context.l10n.auth_label_password;

    final hintText = validation
        ? context.l10n.auth_hint_password_again
        : context.l10n.auth_hint_password;

    return Column(
      children: [
        if (validation) const SizedBox(height: 16),
        TitleTextWidget(
          text: title,
          style: Theme.of(context).textTheme.titleSmall,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        const SizedBox(height: 8.0),
        AuthTextFieldWidget(
          dep,
          isPassword: true,
          hintText: hintText,
          onChanged: (newPass) {
            setState(() {
              if (widget.validation) {
                passAgain = newPass;
              } else {
                pass = newPass;
              }
            });
          },
        ),
      ],
    );
  }
}
