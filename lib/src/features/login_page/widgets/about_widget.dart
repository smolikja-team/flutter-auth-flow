import 'package:firebase_auth_flow/src/core/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class TapabletextWidget extends StatelessWidget {
  const TapabletextWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.opacity,
    this.alignment = Alignment.center,
  });

  final String text;
  final void Function() onTap;
  final Color? color;
  final double? opacity;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Opacity(
          opacity: opacity ?? 1.0,
          child: Align(
            alignment: alignment,
            child: Text(
              text,
              style: TextStyles.labelLarge.copyWith(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
