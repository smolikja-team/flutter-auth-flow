import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/action_button.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/auth_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonsWidget extends ConsumerStatefulWidget {
  const ButtonsWidget(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  ConsumerState<ButtonsWidget> createState() => _ButtonsWidgetState();
}

class _ButtonsWidgetState extends ConsumerState<ButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionButton(
          widget.dep,
          isTypeLogin: isTypeLogin,
          onPressed: isTypeLogin ? _loginPressed : _registerPressed,
        ),
        const SizedBox(height: 16.0),
        AuthSwitchButton(
          widget.dep,
          isTypeLogin: isTypeLogin,
          onPressed: isTypeLogin ? _switchToRegister : _switchToLogin,
        ),
      ],
    );
  }
}
