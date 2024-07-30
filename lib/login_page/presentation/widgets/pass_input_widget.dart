import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/auth_text_field_widget.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PassInputWidget extends ConsumerStatefulWidget {
  const PassInputWidget(this.dep, {required this.validation, super.key});

  final FirebaseAuthFlowDependencies dep;
  final bool validation;

  @override
  ConsumerState<PassInputWidget> createState() => _PassInputWidgetState();
}

class _PassInputWidgetState extends ConsumerState<PassInputWidget> {
  String get title => widget.validation
      ? context.l10n.auth_label_password_again
      : context.l10n.auth_label_password;

  String get hintText => widget.validation
      ? context.l10n.auth_hint_password_again
      : context.l10n.auth_hint_password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.validation) const SizedBox(height: 16),
        TitleTextWidget(
          text: title,
          style: Theme.of(context).textTheme.titleSmall,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        const SizedBox(height: 8.0),
        AuthTextFieldWidget(
          widget.dep,
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
