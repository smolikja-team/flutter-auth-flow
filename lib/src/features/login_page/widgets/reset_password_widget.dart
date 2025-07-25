import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/src/core/text_styles/text_styles.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
    required this.onTap,
    required this.color,
  });

  final void Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        8.0,
        16.0,
        8.0,
        0,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            context.l10n.auth_button_reset_password,
            style: TextStyles.bodyMedium.copyWith(color: color),
          ),
        ),
      ),
    );
  }
}
