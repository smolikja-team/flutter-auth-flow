import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/widgets/custom_outlined_button.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';

class AuthSwitchButton extends StatelessWidget {
  const AuthSwitchButton(
    this.dep, {
    super.key,
    required this.isTypeLogin,
    required this.onPressed,
  });

  final FlutterAuthFlowDependencies dep;
  final bool isTypeLogin;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      title: isTypeLogin
          ? context.l10n.auth_button_switch_register
          : context.l10n.auth_button_switch_login,
      onPressed: onPressed,
      contentColor: dep.colorOnPrimary,
      borderRadius: dep.borderRadius,
    );
  }
}
