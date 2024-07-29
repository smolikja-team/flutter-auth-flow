import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle? withOpacity(double opacity) {
    return copyWith(color: color?.withOpacity(opacity));
  }
}
