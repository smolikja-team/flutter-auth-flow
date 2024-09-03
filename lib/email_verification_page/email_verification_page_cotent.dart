import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/core/widgets/custom_filled_button.dart';
import 'package:firebase_auth_flow/core/widgets/custom_outlined_button.dart';
import 'package:firebase_auth_flow/login_page/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationPageContent extends ConsumerWidget {
  const EmailVerificationPageContent(this.dep, {super.key});

  static const SizedBox kSpacerHeight32 = SizedBox(height: 32.0);
  static const SizedBox kSpacerHeight16 = SizedBox(height: 16.0);

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isTypeLogin = ref.watch(loginProvider).isTypeLogin;

    final title = TitleTextWidget(
      text: 'Ověřte prosím email',
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: dep.colorPrimary),
      alignment: Alignment.center,
    );

    final logOutButton = InkWell(
      onTap: () => {},
      child: Text(
        'Odhlasit se',
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: dep.colorAbout),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        title,
        kSpacerHeight16,
        Text(
          'Email s ověřením naleznete ve své emailové schránce.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: dep.colorPrimary,
          ),
        ),
        kSpacerHeight32,
        CustomFilledButton(
          title: 'Zkontrolovat',
          onPressed: () => {},
          backgroundColor: dep.colorPrimary,
          borderRadius: dep.borderRadius,
        ),
        kSpacerHeight16,
        CustomOutlinedButton(
          title: 'Odeslat znovu',
          onPressed: () => {},
          contentColor: dep.colorPrimary,
          borderRadius: dep.borderRadius,
        ),
        kSpacerHeight32,
        logOutButton,
      ],
    );
  }
}
