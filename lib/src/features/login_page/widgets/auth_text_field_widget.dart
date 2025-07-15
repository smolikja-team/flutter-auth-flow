import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/extensions/text_style_extension.dart';
import 'package:flutter_auth_flow/src/core/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatelessWidget {
  const AuthTextFieldWidget(
    this.dep, {
    super.key,
    required this.hintText,
    required this.isPassword,
    this.obscureText = false,
    required this.onChanged,
  });

  final AuthFlowDependencies dep;
  final String hintText;
  final bool isPassword;
  final bool obscureText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final hintStyle = TextStyles.labelLarge
        .copyWith(color: dep.colorOnSecondary)
        .withAlpha((dep.disabledOpacity * 255).round());

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(dep.borderRadius),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    );

    final fillColor = dep.colorSecondary;

    final style = TextStyles.labelLarge.copyWith(color: dep.colorOnSecondary);

    final cursorColor =
        dep.colorOnPrimary.withAlpha((dep.disabledOpacity * 255).round());

    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        border: border,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.all(16.0),
      ),
      autocorrect: false,
      enableSuggestions: isPassword ? false : true,
      obscureText: obscureText,
      style: style,
      cursorColor: cursorColor,
      cursorOpacityAnimates: true,
      cursorWidth: 1.5,
      onChanged: onChanged,
      keyboardType:
          isPassword ? TextInputType.text : TextInputType.emailAddress,
    );
  }
}
