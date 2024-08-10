/// A FirebaseAuthException maybe thrown with the following error code:
/// - **email-already-in-use**:
///  - Thrown if there already exists an account with the given email address.
/// - **invalid-email**:
///  - Thrown if the email address is not valid.
/// - **operation-not-allowed**:
///  - Thrown if email/password accounts are not enabled. Enable
///    email/password accounts in the Firebase Console, under the Auth tab.
/// - **weak-password**:
///  - Thrown if the password is not strong enough.
/// - **user-disabled**:
///  - Thrown if the user corresponding to the given email has been disabled.
library;

import 'package:firebase_auth_flow/l10n/extension.dart';
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
  invalidCredential('invalid-credential');

  const FirebaseAuthFlowError(this._code);
  final String _code;

  static FirebaseAuthFlowError fromCode(String code) {
    return FirebaseAuthFlowError.values.firstWhere(
      (error) => error._code == code,
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
    }
  }
}
