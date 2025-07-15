import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/src/core/text_styles/text_styles.dart';
import 'package:flutter_auth_flow/src/core/widgets/title_text_widget.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.contentColor,
    required this.borderRadius,
  });

  final String title;
  final void Function() onPressed;
  final Color contentColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: contentColor,
        ),
      ),
      child: TitleTextWidget(
        text: title,
        alignment: Alignment.center,
        style: TextStyles.titleMedium.copyWith(color: contentColor),
      ),
    );
  }
}
