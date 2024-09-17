import 'package:firebase_auth_flow/core/firebase_auth_flow_provider.dart';
import 'package:flutter/material.dart';

class FirebaseAuthFlowDependencies {
  const FirebaseAuthFlowDependencies({
    required this.provider,
    required this.activityIndicator,
    required this.loginAboutText,
    required this.onLoginAboutTextPressed,
    required this.onPrivacyPolicyPressed,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    required this.onCheckVerificationPressed,
    required this.onResendVerificationPressed,
    required this.onLogoutPressed,
    required this.onLoggedIn,
    required this.onLoggedOut,
    this.disabledOpacity = 0.65,
    this.borderRadius = 12.0,
    this.colorPrimary = Colors.black, // TODO: remove mock colors
    this.colorOnSecondary = Colors.grey,
    this.colorAbout = const Color(0xff2a64c5),
    this.colorError,
    this.colorSuccess,
  });

  // MARK: - required

  final FirebaseAuthFlowProvider provider;
  final Widget activityIndicator;
  final String loginAboutText;

  final void Function() onLoginAboutTextPressed;
  final void Function() onPrivacyPolicyPressed;
  final void Function({
    required String email,
    required String password,
    required void Function({String? errorCode, bool? isEmailVerified})
        onLoginDone,
  }) onLoginPressed;
  final void Function({
    required String email,
    required String password,
    required void Function({String? errorCode}) onRegisterDone,
  }) onRegisterPressed;

  final void Function({
    required void Function({String? errorCode, bool? isEmailVerified})
        onCheckDone,
  }) onCheckVerificationPressed;
  final void Function({
    required void Function({String? errorCode}) onResendDone,
  }) onResendVerificationPressed;
  final void Function({
    required void Function({String? errorCode}) onLogoutDone,
  }) onLogoutPressed;

  final void Function() onLoggedIn;
  final void Function() onLoggedOut;

  // MARK: - optional

  final double disabledOpacity;
  final double borderRadius;

  final Color? colorPrimary;
  final Color? colorOnSecondary;
  final Color? colorAbout;
  final Color? colorError;
  final Color? colorSuccess;
}
