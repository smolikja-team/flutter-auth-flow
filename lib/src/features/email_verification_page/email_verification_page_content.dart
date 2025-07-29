import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/text_styles/text_styles.dart';
import 'package:flutter_auth_flow/src/core/widgets/title_text_widget.dart';
import 'package:flutter_auth_flow/src/features/email_verification_page/widgets/verification_bottom_view.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';

class EmailVerificationPageContent extends StatelessWidget {
  const EmailVerificationPageContent(this.dep, {super.key});

  static const SizedBox kSpacerHeight64 = SizedBox(height: 64.0);

  final FlutterAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        kSpacerHeight64,
        TitleTextWidget(
          text: context.l10n.verification_title,
          style: TextStyles.headlineMedium.copyWith(color: dep.colorOnPrimary),
          alignment: Alignment.center,
        ),
        const SizedBox(height: 16.0),
        Text(
          context.l10n.verification_subtitle,
          textAlign: TextAlign.center,
          style: TextStyles.bodyMedium.copyWith(color: dep.colorOnPrimary),
        ),
        kSpacerHeight64,
        VerificationBottomView(dep),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
