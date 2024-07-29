import 'package:firebase_auth_flow/presentation/firebase_auth_flow.dart';
import 'package:firebase_auth_flow/presentation/widgets/auth_text_field_widget.dart';
import 'package:firebase_auth_flow/presentation/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPageContent extends ConsumerStatefulWidget {
  const AuthPageContent(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  ConsumerState<AuthPageContent> createState() => _AuthPageScreenState();
}

class _AuthPageScreenState extends ConsumerState<AuthPageContent> {
  static const EdgeInsets kPaddingHorizontal8 =
      EdgeInsets.symmetric(horizontal: 8.0);
  static const SizedBox kSpacerHeight8 = SizedBox(height: 8.0);
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
              TitleTextWidget(
                text: context.l10n.auth_label_email,
                style: Theme.of(context).textTheme.titleSmall,
                padding: kPaddingHorizontal8,
              ),
              kSpacerHeight8,
              AuthTextFieldWidget(
                widget.dep,
                isPassword: false,
                hintText: context.l10n.auth_hint_email,
                onChanged: (newEmail) {
                  setState(() {
                    email = newEmail;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TitleTextWidget(
                text: context.l10n.auth_label_password,
                style: Theme.of(context).textTheme.titleSmall,
                padding: kPaddingHorizontal8,
              ),
              kSpacerHeight8,
              AuthTextFieldWidget(
                widget.dep,
                isPassword: true,
                hintText: context.l10n.auth_hint_password,
                onChanged: (newPass) {
                  setState(() {
                    pass = newPass;
                  });
                },
              ),
              if (!isTypeLogin) _passwordAgainWidget(),
              const SizedBox(height: 48.0),
              _buttonsWidget(),
              kSpacerHeight32,
              InkWell(
                onTap: _launchMCompURL,
                child: Text(
                  context.l10n.auth_title_mcomp,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: kColorHyperlinkBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
