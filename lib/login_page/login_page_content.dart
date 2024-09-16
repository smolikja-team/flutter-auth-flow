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

class LoginPageContent extends ConsumerStatefulWidget {
  const LoginPageContent(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  ConsumerState<LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends ConsumerState<LoginPageContent>
    with SingleTickerProviderStateMixin {
  static const SizedBox kSpacerHeight32 = SizedBox(height: 32.0);

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTypeLogin = ref.watch(loginProvider).isTypeLogin;
    ref.read(loginProvider.notifier).addListener((state) {
      if (state.isTypeLogin) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });

    final title = TitleTextWidget(
      text: isTypeLogin
          ? context.l10n.auth_title_login
          : context.l10n.auth_title_register,
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: widget.dep.colorPrimary),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        title,
        kSpacerHeight32,
        EmailInputWidget(widget.dep),
        const SizedBox(height: 16.0),
        PassInputWidget(
          widget.dep,
          isConfirming: false,
        ),
        FadeTransition(
          opacity: _fadeAnimation,
          child: isTypeLogin
              ? const SizedBox.shrink()
              : PassInputWidget(
                  widget.dep,
                  isConfirming: true,
                ),
        ),
        const SizedBox(height: 48.0),
        ButtonsWidget(widget.dep),
        kSpacerHeight32,
        AboutWidget(
          text: widget.dep.loginAboutText,
          onTap: widget.dep.onLoginAboutTextPressed,
          color: widget.dep.colorAbout,
        ),
      ],
    );
  }
}
