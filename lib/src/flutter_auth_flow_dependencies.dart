import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/src/core/flutter_auth_flow_error.dart';

class FlutterAuthFlowDependencies {
  const FlutterAuthFlowDependencies({
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
    required this.colorPrimary,
    required this.colorOnPrimary,
    required this.colorSecondary,
    required this.colorOnSecondary,
    required this.colorAbout,
    required this.colorError,
    required this.colorOnError,
    required this.colorSuccess,
    required this.colorOnSuccess,
  });

  // MARK: - required


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
    required void Function({FlutterAuthFlowError? error, bool? isEmailVerified})
        onLoginDone,
  }) onLoginPressed;

  /// The function that is called when the user presses the register button.
  /// This will register the user.
  /// If the registration is successful, the user will be redirected to the email verification page.
  /// If the registration is unsuccessful, the user will be shown an error message.
  final void Function({
    required String email,
    required String password,
    required void Function({FlutterAuthFlowError? error}) onRegisterDone,
  }) onRegisterPressed;

  /// The function that is called when the user presses the check verification button.
  /// This will check if the email is verified.
  /// If the email is verified, the user will be logged in.
  final void Function({
    required void Function({FlutterAuthFlowError? error, bool? isEmailVerified})
        onCheckDone,
  }) onCheckVerificationPressed;

  /// The function that is called when the user presses the resend verification button.
  /// This will resend the email verification.
  /// If the email verification is successful, the user will be shown a success message.
  /// If the email verification is unsuccessful, the user will be shown an error message.
  final void Function({
    required void Function({FlutterAuthFlowError? error}) onResendDone,
  }) onResendVerificationPressed;

  /// The function that is called when the user presses the log out button.
  /// This will log out the user.
  /// If the log out is successful, the user will be redirected to the login page.
  /// If the log out is unsuccessful, the user will be shown an error message.
  final void Function({
    required void Function({FlutterAuthFlowError? error}) onLogoutDone,
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
  final Color colorPrimary;

  /// The color that is used for the text on the primary color.
  final Color colorOnPrimary;

  /// The secondary color that is used for the buttons.
  final Color colorSecondary;

  /// The color that is used for the text on the secondary color.
  final Color colorOnSecondary;

  /// The color that is used for the about text.
  final Color colorAbout;

  /// The color that is used for the error messages.
  final Color colorError;

  /// The color that is used for the error messages.
  final Color colorOnError;

  /// The color that is used for the success messages.
  final Color colorSuccess;

  /// The color that is used for the success messages.
  final Color colorOnSuccess;
}
