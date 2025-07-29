import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/src/core/text_styles/text_styles.dart';

class TapableTextWidget extends StatelessWidget {
  const TapableTextWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    this.opacity,
    this.alignment = Alignment.center,
  });

  final String text;
  final void Function() onTap;
  final Color color;
  final double? opacity;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
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
