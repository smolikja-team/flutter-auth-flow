import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/login_page/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';

SnackBar errorSnackBar({
  required String message,
  required BuildContext context,
  required FirebaseAuthFlowDependencies dependencies,
}) {
  final titleColor = Theme.of(context).scaffoldBackgroundColor;

  final backgroundColor =
      dependencies.colorError ?? Theme.of(context).colorScheme.error;

  return _snackBar(
    message: message,
    context: context,
    titleColor: titleColor,
    backgroundColor: backgroundColor,
    borderRadius: dependencies.borderRadius,
  );
}

SnackBar successSnackBar({
  required String message,
  required BuildContext context,
  required FirebaseAuthFlowDependencies dependencies,
}) {
  final titleColor = Theme.of(context).colorScheme.onPrimary;

  final backgroundColor =
      dependencies.colorSuccess ?? Theme.of(context).colorScheme.primary;

  return _snackBar(
    message: message,
    context: context,
    titleColor: titleColor,
    backgroundColor: backgroundColor,
    borderRadius: dependencies.borderRadius,
  );
}

SnackBar _snackBar({
  required String message,
  required BuildContext context,
  required Color titleColor,
  required Color backgroundColor,
  required double borderRadius,
}) {
  return SnackBar(
    content: TitleTextWidget(
      text: message,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: titleColor,
            fontWeight: FontWeight.bold,
          ),
      alignment: Alignment.center,
    ),
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    behavior: SnackBarBehavior.floating,
  );
}
