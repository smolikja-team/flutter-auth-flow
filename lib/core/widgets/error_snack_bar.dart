import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/login_page/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';

SnackBar errorSnackBar({
  required String message,
  required BuildContext context,
  required FirebaseAuthFlowDependencies dependencies,
}) {
  final titleColor = Theme.of(context).scaffoldBackgroundColor;

  final bgColor =
      dependencies.colorError ?? Theme.of(context).colorScheme.error;

  return SnackBar(
    content: TitleTextWidget(
      text: message,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
      alignment: Alignment.center,
    ),
    backgroundColor: bgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(dependencies.borderRadius),
    ),
    behavior: SnackBarBehavior.floating,
  );
}
