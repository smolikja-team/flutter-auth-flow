import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/widgets/title_text_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/providers/login_provider.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/about_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/buttons_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/email_input_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/pass_input_widget.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPageContent extends ConsumerStatefulWidget {
  const LoginPageContent(this.dep, {super.key});

  final AuthFlowDependencies dep;

  @override
  ConsumerState<LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends ConsumerState<LoginPageContent>
    with SingleTickerProviderStateMixin {
  static const SizedBox _kSpacerHeight32 = SizedBox(height: 32.0);
  static const SizedBox _kSpacerHeight16 = SizedBox(height: 16.0);

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginProvider.notifier).switchToLogin();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTypeLogin = ref.watch(loginProvider).isTypeLogin;

    ref.listen(loginProvider, (prev, now) {
      if (now.isTypeLogin) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });

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
          TapabletextWidget(
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
        FadeTransition(
          opacity: _fadeAnimation,
          child:
              isTypeLogin ? const SizedBox.shrink() : confirmationRegWidget(),
        ),
        if (isTypeLogin) const SizedBox(height: 48.0) else _kSpacerHeight32,
        ButtonsWidget(widget.dep),
        _kSpacerHeight32,
        TapabletextWidget(
          text: widget.dep.loginAboutText,
          onTap: widget.dep.onLoginAboutTextPressed,
          color: widget.dep.colorAbout,
        ),
      ],
    );
  }
}
