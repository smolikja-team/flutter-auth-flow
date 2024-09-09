import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/core/firebase_auth_flow_error.dart';
import 'package:firebase_auth_flow/core/widgets/custom_filled_button.dart';
import 'package:firebase_auth_flow/core/widgets/custom_outlined_button.dart';
import 'package:firebase_auth_flow/core/widgets/error_snack_bar.dart';
import 'package:firebase_auth_flow/email_verification_page/providers/email_verification_provider.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationBottomView extends ConsumerWidget {
  const VerificationBottomView(this.dep, {super.key});

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
            .labelMedium
            ?.copyWith(color: dep.colorAbout),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomFilledButton(
          title: context.l10n.verification_button_check,
          onPressed: () => emailVerificationNotifier.onActionPressed(
            ({required void Function({String? errorCode}) onActionDone}) =>
                dep.onCheckVerificationPressed(onCheckDone: onActionDone),
            onError: showSnackBar,
          ),
          backgroundColor: dep.colorPrimary,
          borderRadius: dep.borderRadius,
        ),
        const SizedBox(height: 16.0),
        CustomOutlinedButton(
          title: context.l10n.verification_button_resend,
          onPressed: () => emailVerificationNotifier.onActionPressed(
            ({required void Function({String? errorCode}) onActionDone}) =>
                dep.onResendVerificationPressed(onResendDone: onActionDone),
            onError: showSnackBar,
          ),
          contentColor: dep.colorPrimary,
          borderRadius: dep.borderRadius,
        ),
        const SizedBox(height: 32.0),
        logOutButton,
      ],
    );
  }
}
