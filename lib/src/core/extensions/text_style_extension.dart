import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  // MARK: - Alpha
  TextStyle? withAlpha(int alpha) {
    return copyWith(
      color: color?.withAlpha(alpha),
    );
  }
}
