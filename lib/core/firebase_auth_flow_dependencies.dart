import 'package:firebase_auth_flow/core/firebase_auth_flow_provider.dart';
import 'package:flutter/material.dart';

class FirebaseAuthFlowDependencies {
  const FirebaseAuthFlowDependencies({
    required this.provider,
    required this.activityIndicator,
    required this.loginAboutText,
    required this.onLoginAboutText,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    this.disabledOpacity = 0.65,
    this.borderRadius = 12.0,
    this.colorPrimary = Colors.black, // TODO: remove colors
    this.colorSecondary = Colors.green,
    this.colorOnSecondary = Colors.grey,
    this.colorAbout = const Color(0xff2a64c5),
    this.colorError,
  });

  // MARK: - required

  final FirebaseAuthFlowProvider provider;
  final Widget activityIndicator;
  final String loginAboutText;
  final void Function() onLoginAboutText;
  final void Function({
    required String email,
    required String password,
    required void Function({String? errorCode}) onLoginDone,
  }) onLoginPressed;
  final void Function({
    required String email,
    required String password,
    required void Function({String? errorCode}) onRegisterDone,
  }) onRegisterPressed;

  // MARK: - optional

  final double disabledOpacity;
  final double borderRadius;

  final Color? colorPrimary;
  final Color? colorSecondary;
  final Color? colorOnSecondary;
  final Color? colorAbout;
  final Color? colorError;
}
