import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/login_page/providers/login_provider.dart';
import 'package:firebase_auth_flow/login_page/widgets/action_button.dart';
import 'package:firebase_auth_flow/login_page/widgets/auth_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonsWidget extends ConsumerWidget {
  const ButtonsWidget(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeLogin = ref.watch(loginProvider).isTypeLogin;
    final loginNotifier = ref.read(loginProvider.notifier);

    return Column(
      children: [
        ActionButton(
          dep,
          isTypeLogin: isTypeLogin,
          onPressed: () => isTypeLogin
              ? loginNotifier.onLoginPressed(dep.onLoginPressed)
              : loginNotifier.onRegisterPressed(dep.onRegisterPressed),
        ),
        const SizedBox(height: 16.0),
        AuthSwitchButton(
          dep,
          isTypeLogin: isTypeLogin,
          onPressed: isTypeLogin
              ? loginNotifier.switchToRegister
              : loginNotifier.switchToLogin,
        ),
      ],
    );
  }
}
