import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/core/widgets/custom_outlined_button.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
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
    final contentColor =
        dep.colorPrimary ?? Theme.of(context).colorScheme.primary;

    return CustomOutlinedButton(
      title: isTypeLogin
          ? context.l10n.auth_button_switch_register
          : context.l10n.auth_button_switch_login,
      onPressed: onPressed,
      contentColor: contentColor,
      borderRadius: dep.borderRadius,
    );
  }
}
