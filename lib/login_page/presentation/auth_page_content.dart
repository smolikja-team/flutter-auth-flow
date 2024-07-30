import 'package:firebase_auth_flow/core/firebase_auth_flow.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/about_widget.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/buttons_widget.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/email_input_widget.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/pass_input_widget.dart';
import 'package:firebase_auth_flow/login_page/presentation/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: naming
class AuthPageContent extends ConsumerStatefulWidget {
  const AuthPageContent(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  ConsumerState<AuthPageContent> createState() => _AuthPageScreenState();
}

// TODO: naming
class _AuthPageScreenState extends ConsumerState<AuthPageContent> {
  static const SizedBox kSpacerHeight32 = SizedBox(height: 32.0);
  static const Color kColorHyperlinkBlue = Color(0xff2a64c5);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleTextWidget(
                text: isTypeLogin
                    ? context.l10n.auth_title_login
                    : context.l10n.auth_title_register,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              kSpacerHeight32,
              EmailInputWidget(widget.dep),
              const SizedBox(height: 16.0),
              PassInputWidget(
                widget.dep,
                validation: false,
              ),
              if (!isTypeLogin)
                PassInputWidget(
                  widget.dep,
                  validation: true,
                ),
              const SizedBox(height: 48.0),
              ButtonsWidget(widget.dep),
              kSpacerHeight32,
              AboutWidget(
                text: widget.dep.loginAboutText,
                onTap: widget.dep.onLoginAboutText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
