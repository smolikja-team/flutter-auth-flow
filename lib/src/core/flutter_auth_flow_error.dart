/// Flutter Auth Flow errors - pure enum without string codes
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_auth_flow/src/l10n/extension.dart';

enum FlutterAuthFlowError {
  universal,
  weakPassword,
  emailInUse,
  userNotFound,
  wrongPassword,
  emailInvalid,
  passwordNotMatching,
  operationNotAllowed,
  userDisabled,
  invalidCredential,
  emailNotVerified,
  userLoggedOut,
}

extension FlutterAuthFlowErrorExtension on FlutterAuthFlowError {
  /// Returns the error message for the given [context].
  String message(BuildContext context) {
    switch (this) {
      case FlutterAuthFlowError.universal:
        return context.l10n.error_universal;
      case FlutterAuthFlowError.weakPassword:
        return context.l10n.error_auth_weak_password;
      case FlutterAuthFlowError.emailInUse:
        return context.l10n.error_auth_email_in_use;
      case FlutterAuthFlowError.userNotFound:
        return context.l10n.error_auth_user_not_found;
      case FlutterAuthFlowError.wrongPassword:
        return context.l10n.error_auth_wrong_password;
      case FlutterAuthFlowError.emailInvalid:
        return context.l10n.error_auth_email_invalid;
      case FlutterAuthFlowError.passwordNotMatching:
        return context.l10n.error_auth_pass_not_matching;
      case FlutterAuthFlowError.operationNotAllowed:
        return context.l10n.error_auth_operation_not_allowed;
      case FlutterAuthFlowError.userDisabled:
        return context.l10n.error_auth_user_disabled;
      case FlutterAuthFlowError.invalidCredential:
        return context.l10n.error_auth_invalid_credential;
      case FlutterAuthFlowError.emailNotVerified:
        return context.l10n.error_email_not_verified;
      case FlutterAuthFlowError.userLoggedOut:
        return context.l10n.error_user_logged_out;
    }
  }
}
