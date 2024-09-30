/// A FirebaseAuthException maybe thrown with the following error code:
/// https://firebase.google.com/docs/auth/admin/errors
library;

import 'package:firebase_auth_flow/src/l10n/extension.dart';
import 'package:flutter/widgets.dart';

enum FirebaseAuthFlowError {
  universal('something-went-wrong'),
  weakPassword('weak-password'),
  emailInUse('email-already-in-use'),
  userNotFound('user-not-found'),
  wrongPassword('wrong-password'),
  emailInvalid('invalid-email'),
  passwordNotMatching('pass-not-match'),
  operationNotAllowed('operation-not-allowed'),
  userDisabled('user-disabled'),
  invalidCredential('invalid-credential'),
  emailNotVerified('email-not-verified'),
  userLoggedOut('user-logged-out');

  const FirebaseAuthFlowError(this.code);
  final String code;

  static FirebaseAuthFlowError fromCode(String code) {
    return FirebaseAuthFlowError.values.firstWhere(
      (error) => error.code == code,
      orElse: () => FirebaseAuthFlowError.universal,
    );
  }

  String message(BuildContext context) {
    switch (this) {
      case FirebaseAuthFlowError.universal:
        return context.l10n.error_universal;
      case FirebaseAuthFlowError.weakPassword:
        return context.l10n.error_auth_weak_password;
      case FirebaseAuthFlowError.emailInUse:
        return context.l10n.error_auth_email_in_use;
      case FirebaseAuthFlowError.userNotFound:
        return context.l10n.error_auth_user_not_found;
      case FirebaseAuthFlowError.wrongPassword:
        return context.l10n.error_auth_wrong_password;
      case FirebaseAuthFlowError.emailInvalid:
        return context.l10n.error_auth_email_invalid;
      case FirebaseAuthFlowError.passwordNotMatching:
        return context.l10n.error_auth_pass_not_matching;
      case FirebaseAuthFlowError.operationNotAllowed:
        return context.l10n.error_auth_operation_not_allowed;
      case FirebaseAuthFlowError.userDisabled:
        return context.l10n.error_auth_user_disabled;
      case FirebaseAuthFlowError.invalidCredential:
        return context.l10n.error_auth_invalid_credential;
      case FirebaseAuthFlowError.emailNotVerified:
        return context.l10n.error_email_not_verified;
      case FirebaseAuthFlowError.userLoggedOut:
        return context.l10n.error_user_logged_out;
    }
  }
}
