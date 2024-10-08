import 'package:firebase_auth_flow/firebase_auth_flow.dart';
import 'package:firebase_auth_flow/src/core/extensions/text_style_extension.dart';
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

  final FirebaseAuthFlowDependencies dep;
  final String hintText;
  final bool isPassword;
  final bool obscureText;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final hintStyle = Theme.of(context)
        .textTheme
        .labelLarge
        ?.copyWith(color: dep.colorPrimary)
        .withOpacity(dep.disabledOpacity);

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(dep.borderRadius),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    );

    final fillColor =
        dep.colorOnSecondary ?? Theme.of(context).colorScheme.onSecondary;

    final style = Theme.of(context)
        .textTheme
        .labelLarge
        ?.copyWith(color: dep.colorPrimary);

    final cursorColor =
        dep.colorPrimary ?? Theme.of(context).colorScheme.primary;

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
      cursorColor: cursorColor.withOpacity(dep.disabledOpacity),
      cursorOpacityAnimates: true,
      cursorWidth: 1.5,
      onChanged: onChanged,
      keyboardType:
          isPassword ? TextInputType.text : TextInputType.emailAddress,
    );
  }
}
