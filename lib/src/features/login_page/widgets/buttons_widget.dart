import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/widgets/custom_snack_bars.dart';
import 'package:flutter_auth_flow/src/features/login_page/providers/login_provider.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/action_button.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/auth_switch_button.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonsWidget extends ConsumerWidget {
  const ButtonsWidget(this.dep, {super.key});

  final FlutterAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeLogin = ref.watch(loginProvider).isTypeLogin;
    final loginNotifier = ref.read(loginProvider.notifier);

    void showSnackBar({required String errorMessage}) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(
          message: errorMessage,
          context: context,
          dependencies: dep,
        ),
      );
    }

    return Column(
      children: [
        ActionButton(
          dep,
          isTypeLogin: isTypeLogin,
          onPressed: () => isTypeLogin
              ? loginNotifier.onLoginPressed(
                  dep.onLoginPressed,
                  onError: showSnackBar,
                  onLoggedIn: dep.onLoggedIn,
                )
              : loginNotifier.onRegisterPressed(
                  dep.onRegisterPressed,
                  onError: showSnackBar,
                  passNotMatchingMessage:
                      context.l10n.error_auth_pass_not_matching,
                ),
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
