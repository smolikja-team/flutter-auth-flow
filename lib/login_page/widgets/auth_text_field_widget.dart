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
        ?.copyWith(color: dep.primary);

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(dep.borderRadius),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    );

    final fillColor = dep.secondary ?? Theme.of(context).colorScheme.secondary;

    final style =
        Theme.of(context).textTheme.labelLarge?.copyWith(color: dep.onPrimary);

    final cursorColor = dep.onPrimary?.withOpacity(dep.disabledOpacity) ??
        Theme.of(context)
            .colorScheme
            .onPrimary
            .withOpacity(dep.disabledOpacity);

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
