import 'package:firebase_auth_flow/core/firebase_auth_flow_error.dart';
import 'package:firebase_auth_flow/email_verification_page/providers/email_verification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailVerificationProvider =
    StateNotifierProvider<EmailVerificationNotifier, EmailVerificationState>(
  (ref) => EmailVerificationNotifier(),
);

class EmailVerificationNotifier extends StateNotifier<EmailVerificationState> {
  EmailVerificationNotifier() : super(EmailVerificationState());

  void onActionPressed(
    void Function({
      required void Function({String? errorCode}) onActionDone,
    }) onActionPressed, {
    required void Function({required FirebaseAuthFlowError error}) onError,
  }) {
    state = state.copyWith(isLoading: true);
    onActionPressed(
      onActionDone: ({String? errorCode}) {
        _onActionDone(errorCode: errorCode, onError: onError);
      },
    );
  }

  void _onActionDone({
    String? errorCode,
    required void Function({required FirebaseAuthFlowError error}) onError,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorCode != null) {
      final error = FirebaseAuthFlowError.fromCode(errorCode);
      onError(error: error);
      return;
    }
    print("=== action succeeded");
  }
}
