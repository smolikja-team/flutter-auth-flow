import 'package:firebase_auth_flow/src/core/firebase_auth_flow_dependencies.dart';
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
    final bgColor = dep.colorPrimary ?? Theme.of(context).colorScheme.primary;

    return CustomFilledButton(
      title: isTypeLogin
          ? context.l10n.auth_button_action_login
          : context.l10n.auth_button_action_register,
      onPressed: onPressed,
      backgroundColor: bgColor,
      borderRadius: dep.borderRadius,
    );
  }
}
