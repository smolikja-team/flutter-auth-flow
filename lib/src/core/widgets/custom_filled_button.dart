import 'package:firebase_auth_flow/src/core/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    required this.borderRadius,
  });

  final String title;
  final void Function() onPressed;
  final Color? backgroundColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: TitleTextWidget(
        text: title,
        alignment: Alignment.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
      ),
    );
  }
}
