import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/l10n/extension.dart';
import 'package:firebase_auth_flow/login_page/providers/login_provider.dart';
import 'package:firebase_auth_flow/login_page/widgets/auth_text_field_widget.dart';
import 'package:firebase_auth_flow/login_page/widgets/title_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PassInputWidget extends ConsumerWidget {
  const PassInputWidget(this.dep, {required this.isConfirming, super.key});

  final FirebaseAuthFlowDependencies dep;
  final bool isConfirming;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hintText = isConfirming
        ? context.l10n.auth_hint_password_again
        : context.l10n.auth_hint_password;

    final loginNotifier = ref.read(loginProvider.notifier);

    return Column(
      children: [
        if (isConfirming) const SizedBox(height: 16),
        if (isConfirming)
          _titleWidget(context)
        else
          _titleWithHelpWidget(context),
        const SizedBox(height: 8.0),
        AuthTextFieldWidget(
          dep,
          isPassword: true,
          hintText: hintText,
          onChanged: isConfirming
              ? loginNotifier.setPasswordConf
              : loginNotifier.setPassword,
        ),
      ],
    );
  }

  TitleTextWidget _titleWidget(BuildContext context) {
    final title = isConfirming
        ? context.l10n.auth_label_password_again
        : context.l10n.auth_label_password;

    return TitleTextWidget(
      text: title,
      style: Theme.of(context).textTheme.titleSmall,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
    );
  }

  Widget _titleWithHelpWidget(BuildContext context) {
    return Row(
      children: [
        _titleWidget(context),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            child: _helpIcon(context),
            onTap: () => _showAlertDialog(
              context,
              title: context.l10n.auth_help_password_title,
              content: context.l10n.auth_help_password_content,
            ),
          ),
        ),
      ],
    );
  }

  Icon _helpIcon(BuildContext context) {
    return Icon(
      Icons.help_outline_rounded,
      color: Theme.of(context)
          .textTheme
          .titleSmall
          ?.color
          ?.withOpacity(dep.disabledOpacity),
      size: Theme.of(context).textTheme.titleSmall?.fontSize,
    );
  }

  void _showAlertDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: TitleTextWidget(
          text: title,
          alignment: Alignment.center,
        ),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: TitleTextWidget(
              text: context.l10n.auth_help_password_ok,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
