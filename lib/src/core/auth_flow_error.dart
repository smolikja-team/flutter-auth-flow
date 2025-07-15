/// Authentication flow errors with standardized error codes
library;

import 'package:flutter_auth_flow/src/l10n/extension.dart';
import 'package:flutter/widgets.dart';

enum AuthFlowError {
  universal('auth-error'),
  weakPassword('weak-password'),
  emailInUse('email-in-use'),
  userNotFound('user-not-found'),
  wrongPassword('wrong-password'),
  emailInvalid('email-invalid'),
  passwordNotMatching('password-not-matching'),
  operationNotAllowed('operation-not-allowed'),
  userDisabled('user-disabled'),
  invalidCredential('invalid-credential'),
  emailNotVerified('email-not-verified'),
  userLoggedOut('user-logged-out');

  const AuthFlowError(this.code);
  final String code;

  /// Returns the [AuthFlowError] from the given [code].
  /// If the [code] is not found, [AuthFlowError.universal] is returned.
  static AuthFlowError fromCode(String code) {
    return AuthFlowError.values.firstWhere(
      (error) => error.code == code,
      orElse: () => AuthFlowError.universal,
    );
  }

  /// Returns the error message for the given [context].
  String message(BuildContext context) {
    switch (this) {
      case AuthFlowError.universal:
        return context.l10n.error_universal;
      case AuthFlowError.weakPassword:
        return context.l10n.error_auth_weak_password;
      case AuthFlowError.emailInUse:
        return context.l10n.error_auth_email_in_use;
      case AuthFlowError.userNotFound:
        return context.l10n.error_auth_user_not_found;
      case AuthFlowError.wrongPassword:
        return context.l10n.error_auth_wrong_password;
      case AuthFlowError.emailInvalid:
        return context.l10n.error_auth_email_invalid;
      case AuthFlowError.passwordNotMatching:
        return context.l10n.error_auth_pass_not_matching;
      case AuthFlowError.operationNotAllowed:
        return context.l10n.error_auth_operation_not_allowed;
      case AuthFlowError.userDisabled:
        return context.l10n.error_auth_user_disabled;
      case AuthFlowError.invalidCredential:
        return context.l10n.error_auth_invalid_credential;
      case AuthFlowError.emailNotVerified:
        return context.l10n.error_email_not_verified;
      case AuthFlowError.userLoggedOut:
        return context.l10n.error_user_logged_out;
    }
  }
}
