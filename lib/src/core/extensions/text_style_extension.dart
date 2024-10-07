import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  /// Returns a new [TextStyle] with the specified [color].
  TextStyle? withOpacity(double opacity) {
    return copyWith(color: color?.withOpacity(opacity));
  }
}
