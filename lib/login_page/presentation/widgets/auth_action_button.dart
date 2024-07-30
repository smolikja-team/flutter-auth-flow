import 'package:firebase_auth_flow/core/firebase_auth_flow.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  const AuthActionButton(
    this.dep, {
    super.key,
    required this.isTypeLogin,
    required this.onPressed,
  });

  final FirebaseAuthFlowDependencies dep;
  final bool isTypeLogin;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dep.borderRadius),
        ),
      ),
      child: TitleTextWidget(
        text: isTypeLogin
            ? context.l10n.auth_button_action_login
            : context.l10n.auth_button_action_register,
        alignment: Alignment.center,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
