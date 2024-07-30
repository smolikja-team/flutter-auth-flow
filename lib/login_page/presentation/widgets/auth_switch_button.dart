import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';

class AuthSwitchButton extends StatelessWidget {
  const AuthSwitchButton(
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
    return OutlinedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dep.borderRadius),
        ),
        backgroundColor: Colors.transparent,
      ),
      child: TitleTextWidget(
        text: isTypeLogin
            ? context.l10n.auth_button_switch_register
            : context.l10n.auth_button_switch_login,
        alignment: Alignment.center,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
