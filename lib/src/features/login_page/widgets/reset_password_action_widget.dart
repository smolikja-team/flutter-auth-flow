import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/text_styles/text_styles.dart';
import 'package:flutter_auth_flow/src/core/widgets/custom_snack_bars.dart';
import 'package:flutter_auth_flow/src/core/widgets/title_text_widget.dart';
import 'package:flutter_auth_flow/src/features/login_page/providers/login_provider.dart';
import 'package:flutter_auth_flow/src/features/login_page/widgets/reset_password_widget.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordActionWidget extends ConsumerWidget {
  const ResetPasswordActionWidget(this.dep, {super.key});

  final FlutterAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (dep.onResetPasswordPressed == null) {
      return const SizedBox.shrink();
    }

    return ResetPasswordWidget(
      onTap: () {
        final email = ref.read(loginProvider).email.trim();
        if (email.isEmpty) {
          _showEmptyEmailDialog(context);
        } else {
          _showResetPasswordDialog(
            context,
            () => ref.read(loginProvider.notifier).onResetPasswordPressed(
              dep.onResetPasswordPressed!,
              onError: ({required String errorMessage}) {
                _showSnackBar(context, errorMessage: errorMessage);
              },
            ),
          );
        }
      },
      color: dep.colorOnPrimary,
    );
  }

  void _showSnackBar(BuildContext context, {required String errorMessage}) {
    ScaffoldMessenger.of(context).showSnackBar(
      errorSnackBar(
        message: errorMessage,
        context: context,
        dependencies: dep,
      ),
    );
  }

  void _showResetPasswordDialog(
    BuildContext context,
    void Function() onResetPassword,
  ) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: TitleTextWidget(
          text: context.l10n.auth_button_reset_password,
          alignment: Alignment.center,
        ),
        content: Text(context.l10n.auth_message_reset_password),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.l10n.auth_help_password_cancel,
              style: TextStyles.titleMedium.copyWith(color: dep.colorError),
            ),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              onResetPassword();
              Navigator.pop(context);
            },
            child: Text(
              context.l10n.auth_help_password_ok,
              style: TextStyles.titleMedium.copyWith(color: dep.colorOnPrimary),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmptyEmailDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: TitleTextWidget(
          text: context.l10n.auth_button_reset_password,
          alignment: Alignment.center,
        ),
        content: Text(context.l10n.auth_message_reset_password_empty),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.l10n.auth_help_password_ok,
              style: TextStyles.titleMedium.copyWith(color: dep.colorOnPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
