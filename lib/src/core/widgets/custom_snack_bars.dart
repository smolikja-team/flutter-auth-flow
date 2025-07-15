import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/text_styles/text_styles.dart';
import 'package:flutter_auth_flow/src/core/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';

SnackBar errorSnackBar({
  required String message,
  required BuildContext context,
  required AuthFlowDependencies dependencies,
}) {
  final titleColor = dependencies.colorOnError;
  final backgroundColor = dependencies.colorError;

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
  required AuthFlowDependencies dependencies,
}) {
  final titleColor = dependencies.colorOnSuccess;
  final backgroundColor = dependencies.colorSuccess;

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
      style: TextStyles.labelLargeBold.copyWith(
        color: titleColor,
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
