import 'package:firebase_auth_flow/src/firebase_auth_flow_provider.dart';
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
    this.colorPrimary,
    this.colorOnSecondary,
    this.colorAbout = const Color(0xff2a64c5),
    this.colorError,
    this.colorSuccess,
  });

  // MARK: - required

  /// The provider that is used to access the FirebaseAuthFlow state.
  final FirebaseAuthFlowProvider provider;

  /// The activity indicator that is shown when the user is waiting for a response.
  final Widget activityIndicator;

  /// The text that is shown when the user wants to know more about the login process.
  final String loginAboutText;

  /// The function that is called when the user presses the login about text.
  /// This will show the user more information about the login process.
  final void Function() onLoginAboutTextPressed;

  /// The function that is called when the user presses the privacy policy text.
  /// This will show the user the privacy policy.
  final void Function() onPrivacyPolicyPressed;

  /// The function that is called when the user presses the login button.
  /// This will log the user in.
  /// If the login is successful, the user will be redirected to the email verification page.
  /// If the login is unsuccessful, the user will be shown an error message.
  final void Function({
    required String email,
    required String password,
    required void Function({String? errorCode, bool? isEmailVerified})
        onLoginDone,
  }) onLoginPressed;

  /// The function that is called when the user presses the register button.
  /// This will register the user.
  /// If the registration is successful, the user will be redirected to the email verification page.
  /// If the registration is unsuccessful, the user will be shown an error message.
  final void Function({
    required String email,
    required String password,
    required void Function({String? errorCode}) onRegisterDone,
  }) onRegisterPressed;

  /// The function that is called when the user presses the check verification button.
  /// This will check if the email is verified.
  /// If the email is verified, the user will be logged in.
  final void Function({
    required void Function({String? errorCode, bool? isEmailVerified})
        onCheckDone,
  }) onCheckVerificationPressed;

  /// The function that is called when the user presses the resend verification button.
  /// This will resend the email verification.
  /// If the email verification is successful, the user will be shown a success message.
  /// If the email verification is unsuccessful, the user will be shown an error message.
  final void Function({
    required void Function({String? errorCode}) onResendDone,
  }) onResendVerificationPressed;

  /// The function that is called when the user presses the log out button.
  /// This will log out the user.
  /// If the log out is successful, the user will be redirected to the login page.
  /// If the log out is unsuccessful, the user will be shown an error message.
  final void Function({
    required void Function({String? errorCode}) onLogoutDone,
  }) onLogoutPressed;

  /// The function that is called when the user is logged in.
  final void Function() onLoggedIn;

  /// The function that is called when the user is logged out.
  final void Function() onLoggedOut;

  // MARK: - optional

  /// The opacity that is used when the button is disabled.
  /// Default is 0.65.
  final double disabledOpacity;

  /// The border radius that is used for the buttons.
  /// Default is 12.0.
  final double borderRadius;

  /// The primary color that is used for the buttons.
  /// Default is Theme.of(context).colorScheme.primary.
  final Color? colorPrimary;

  /// The color that is used for the text on the secondary color.
  /// Default is Theme.of(context).colorScheme.onSecondary.
  final Color? colorOnSecondary;

  /// The color that is used for the about text.
  /// Default is Color(0xff2a64c5).
  final Color? colorAbout;

  /// The color that is used for the error messages.
  /// Default is Theme.of(context).colorScheme.error.
  final Color? colorError;

  /// The color that is used for the success messages.
  /// Default is Theme.of(context).colorScheme.success.
  final Color? colorSuccess;
}
