import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({
    required this.text,
    this.style,
    super.key,
    this.padding = const EdgeInsets.all(0),
    this.alignment = Alignment.centerLeft,
  });

  final String text;
  final TextStyle? style;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          overflow: TextOverflow.fade,
          maxLines: 1,
          softWrap: false,
          style: style,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
