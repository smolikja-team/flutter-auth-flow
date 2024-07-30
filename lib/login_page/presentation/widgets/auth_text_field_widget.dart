import 'package:firebase_auth_flow/core/firebase_auth_flow.dart';
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
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.withOpacity(dep.disabledOpacity),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dep.borderRadius),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        contentPadding: const EdgeInsets.all(16.0),
      ),
      autocorrect: false,
      enableSuggestions: isPassword ? false : true,
      obscureText: isPassword ? true : false,
      style: Theme.of(context).textTheme.labelLarge,
      cursorColor: Theme.of(context)
          .colorScheme
          .onPrimary
          .withOpacity(dep.disabledOpacity),
      cursorOpacityAnimates: true,
      cursorWidth: 1.5,
      onChanged: onChanged,
      keyboardType:
          isPassword ? TextInputType.text : TextInputType.emailAddress,
    );
  }
}
