import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/auth_text_field_widget.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailInputWidget extends ConsumerStatefulWidget {
  const EmailInputWidget(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  ConsumerState<EmailInputWidget> createState() => _EmailInputWidgetState();
}

class _EmailInputWidgetState extends ConsumerState<EmailInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleTextWidget(
          text: context.l10n.auth_label_email,
          style: Theme.of(context).textTheme.titleSmall,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        const SizedBox(height: 8.0),
        AuthTextFieldWidget(
          widget.dep,
          isPassword: false,
          hintText: context.l10n.auth_hint_email,
          onChanged: (newEmail) {
            setState(() {
              email = newEmail;
            });
          },
        ),
      ],
    );
  }
}
