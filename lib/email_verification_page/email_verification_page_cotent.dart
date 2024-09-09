import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/core/firebase_auth_flow_error.dart';
import 'package:firebase_auth_flow/core/widgets/custom_filled_button.dart';
import 'package:firebase_auth_flow/core/widgets/custom_outlined_button.dart';
import 'package:firebase_auth_flow/core/widgets/error_snack_bar.dart';
import 'package:firebase_auth_flow/email_verification_page/providers/email_verification_provider.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationPageContent extends ConsumerWidget {
  const EmailVerificationPageContent(this.dep, {super.key});

  static const SizedBox kSpacerHeight48 = SizedBox(height: 48.0);
  static const SizedBox kSpacerHeight16 = SizedBox(height: 16.0);

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailVerificationNotifier =
        ref.read(emailVerificationProvider.notifier);

    void showSnackBar({required FirebaseAuthFlowError error}) {
      ScaffoldMessenger.of(context).showSnackBar(
        errorSnackBar(
          message: error.message(context),
          context: context,
          dependencies: dep,
        ),
      );
    }

    final title = TitleTextWidget(
      text: context.l10n.verification_title,
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: dep.colorPrimary),
      alignment: Alignment.center,
    );

    final logOutButton = InkWell(
      onTap: () => emailVerificationNotifier.onActionPressed(
        ({required void Function({String? errorCode}) onActionDone}) =>
            dep.onLogoutPressed(onLogoutDone: onActionDone),
        onError: showSnackBar,
      ),
      child: Text(
        context.l10n.verification_button_logout,
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
          context.l10n.verification_subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: dep.colorPrimary,
          ),
        ),
        kSpacerHeight48,
        CustomFilledButton(
          title: context.l10n.verification_button_check,
          onPressed: () => emailVerificationNotifier.onActionPressed(
            ({required void Function({String? errorCode}) onActionDone}) =>
                dep.onCheckConfirmationPressed(onCheckDone: onActionDone),
            onError: showSnackBar,
          ),
          backgroundColor: dep.colorPrimary,
          borderRadius: dep.borderRadius,
        ),
        kSpacerHeight16,
        CustomOutlinedButton(
          title: context.l10n.verification_button_resend,
          onPressed: () => emailVerificationNotifier.onActionPressed(
            ({required void Function({String? errorCode}) onActionDone}) =>
                dep.onResendConfirmationPressed(onResendDone: onActionDone),
            onError: showSnackBar,
          ),
          contentColor: dep.colorPrimary,
          borderRadius: dep.borderRadius,
        ),
        kSpacerHeight48,
        logOutButton,
      ],
    );
  }
}
