import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatelessWidget {
  const AuthTextFieldWidget(
    this.dep, {
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.onChanged,
  });

  final FirebaseAuthFlowDependencies dep;
  final String hintText;
  final bool isPassword;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final hintStyle = Theme.of(context)
        .textTheme
        .labelLarge
        ?.withOpacity(dep.disabledOpacity)
        ?.copyWith(color: dep.colorOnPrimary);

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

    final cursorColor = dep.colorPrimary?.withOpacity(dep.disabledOpacity) ??
        Theme.of(context).colorScheme.primary.withOpacity(dep.disabledOpacity);

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
      obscureText: isPassword ? true : false,
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
