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

enum FirebaseAuthFlowError {
  universal('something-went-wrong'),
  weakPassword('weak-password'),
  emailInUse('email-already-in-use'),
  usernotFound('user-not-found'),
  wrongPassword('wrong-password'),
  emailInvalid('invalid-email'),
  passwordNotMatching('pass-not-match'),
  operationNotAllowed('operation-not-allowed'),
  userDisabled('user-disabled');

  const FirebaseAuthFlowError(this.code);
  final String code;
}
