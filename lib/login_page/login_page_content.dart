import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/providers/login_provider.dart';
import 'package:firebase_auth_flow/login_page/widgets/about_widget.dart';
import 'package:firebase_auth_flow/login_page/widgets/buttons_widget.dart';
import 'package:firebase_auth_flow/login_page/widgets/email_input_widget.dart';
import 'package:firebase_auth_flow/login_page/widgets/pass_input_widget.dart';
import 'package:firebase_auth_flow/login_page/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPageContent extends ConsumerWidget {
  const LoginPageContent(this.dep, {super.key});

  static const SizedBox kSpacerHeight32 = SizedBox(height: 32.0);

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeLogin = ref.watch(loginProvider).isTypeLogin;

    final title = TitleTextWidget(
      text: isTypeLogin
          ? context.l10n.auth_title_login
          : context.l10n.auth_title_register,
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: dep.colorPrimary),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        title,
        kSpacerHeight32,
        EmailInputWidget(dep),
        const SizedBox(height: 16.0),
        PassInputWidget(
          dep,
          isConfirming: false,
        ),
        if (!isTypeLogin)
          PassInputWidget(
            dep,
            isConfirming: true,
          ),
        const SizedBox(height: 48.0),
        ButtonsWidget(dep),
        kSpacerHeight32,
        AboutWidget(
          text: dep.loginAboutText,
          onTap: dep.onLoginAboutTextPressed,
          color: dep.colorAbout,
        ),
      ],
    );
  }
}
