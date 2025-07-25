import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/widgets/title_text_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/providers/login_provider.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/buttons_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/email_input_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/pass_input_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/reset_password_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/tapable_text_widget.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPageContent extends ConsumerStatefulWidget {
  const LoginPageContent(this.dep, {super.key});

  final FlutterAuthFlowDependencies dep;

  @override
  ConsumerState<LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends ConsumerState<LoginPageContent> {
  static const SizedBox _kSpacerHeight32 = SizedBox(height: 32.0);
  static const SizedBox _kSpacerHeight16 = SizedBox(height: 16.0);
  static const ValueKey _kResetPasswordKey = ValueKey('reset_password');
  static const ValueKey _kConfirmationRegKey = ValueKey('confirmation_reg');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginProvider.notifier).switchToLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTypeLogin = ref.watch(loginProvider).isTypeLogin;

    final title = TitleTextWidget(
      text: isTypeLogin
          ? context.l10n.auth_title_login
          : context.l10n.auth_title_register,
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: widget.dep.colorOnPrimary),
    );

    Widget confirmationRegWidget() {
      return Column(
        children: [
          PassInputWidget(
            widget.dep,
            isConfirming: true,
          ),
          _kSpacerHeight16,
          TapableTextWidget(
            text: context.l10n.auth_title_privacy_policy,
            onTap: widget.dep.onPrivacyPolicyPressed,
            color: widget.dep.colorPrimary,
            opacity: widget.dep.disabledOpacity,
            alignment: Alignment.centerLeft,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        title,
        _kSpacerHeight32,
        EmailInputWidget(widget.dep),
        _kSpacerHeight16,
        PassInputWidget(
          widget.dep,
          isConfirming: false,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.95,
                  end: 1.0,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              ),
            );
          },
          child: isTypeLogin
              ? ResetPasswordWidget(
                  key: _kResetPasswordKey,
                  onTap: () {},
                  color: widget.dep.colorOnPrimary,
                )
              : Container(
                  key: _kConfirmationRegKey,
                  child: confirmationRegWidget(),
                ),
        ),
        if (isTypeLogin) const SizedBox(height: 48.0) else _kSpacerHeight32,
        ButtonsWidget(widget.dep),
        _kSpacerHeight32,
        TapableTextWidget(
          text: widget.dep.loginAboutText,
          onTap: widget.dep.onLoginAboutTextPressed,
          color: widget.dep.colorAbout,
        ),
      ],
    );
  }
}
