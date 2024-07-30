import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/login_page/widgets/action_button.dart';
import 'package:firebase_auth_flow/login_page/widgets/auth_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonsWidget extends ConsumerWidget {
  const ButtonsWidget(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ActionButton(
          dep,
          isTypeLogin: isTypeLogin,
          onPressed: isTypeLogin ? _loginPressed : _registerPressed,
        ),
        const SizedBox(height: 16.0),
        AuthSwitchButton(
          dep,
          isTypeLogin: isTypeLogin,
          onPressed: isTypeLogin ? _switchToRegister : _switchToLogin,
        ),
      ],
    );
  }
}
