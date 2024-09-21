import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/core/widgets/title_text_widget.dart';
import 'package:firebase_auth_flow/features/email_verification_page/widgets/verification_bottom_view.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:flutter/material.dart';

class EmailVerificationPageContent extends StatelessWidget {
  const EmailVerificationPageContent(this.dep, {super.key});

  static const SizedBox kSpacerHeight64 = SizedBox(height: 64.0);

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        kSpacerHeight64,
        TitleTextWidget(
          text: context.l10n.verification_title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: dep.colorPrimary),
          alignment: Alignment.center,
        ),
        const SizedBox(height: 16.0),
        Text(
          context.l10n.verification_subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: dep.colorPrimary),
        ),
        kSpacerHeight64,
        VerificationBottomView(dep),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
