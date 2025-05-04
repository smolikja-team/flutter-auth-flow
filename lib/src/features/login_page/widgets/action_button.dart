import 'package:firebase_auth_flow/firebase_auth_flow.dart';
import 'package:firebase_auth_flow/src/core/widgets/custom_filled_button.dart';
import 'package:firebase_auth_flow/src/l10n/extension.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
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
    return CustomFilledButton(
      title: isTypeLogin
          ? context.l10n.auth_button_action_login
          : context.l10n.auth_button_action_register,
      onPressed: onPressed,
      textColor: dep.colorOnPrimary,
      backgroundColor: dep.colorPrimary,
      borderRadius: dep.borderRadius,
    );
  }
}
