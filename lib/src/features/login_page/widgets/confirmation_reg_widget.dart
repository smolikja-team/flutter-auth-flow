import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/pass_input_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/tapable_text_widget.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';

class ConfirmationRegWidget extends StatelessWidget {
  const ConfirmationRegWidget(this.dep, {super.key});

  final FlutterAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PassInputWidget(
          dep,
          isConfirming: true,
        ),
        const SizedBox(height: 16.0),
        TapableTextWidget(
          text: context.l10n.auth_title_privacy_policy,
          onTap: dep.onPrivacyPolicyPressed,
          color: dep.colorPrimary,
          opacity: dep.disabledOpacity,
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
