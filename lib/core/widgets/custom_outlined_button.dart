import 'package:firebase_auth_flow/login_page/widgets/title_text_widget.dart';
import 'package:flutter/material.dart';

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
  final Color? contentColor;
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
          color: contentColor ?? Theme.of(context).colorScheme.primary,
        ),
      ),
      child: TitleTextWidget(
        text: title,
        alignment: Alignment.center,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: contentColor),
      ),
    );
  }
}
