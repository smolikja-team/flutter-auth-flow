import 'package:firebase_auth_flow/core/firebase_auth_flow_error.dart';
import 'package:firebase_auth_flow/email_verification_page/providers/email_verification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailVerificationProvider =
    StateNotifierProvider<EmailVerificationNotifier, EmailVerificationState>(
  (ref) => EmailVerificationNotifier(),
);

class EmailVerificationNotifier extends StateNotifier<EmailVerificationState> {
  EmailVerificationNotifier() : super(EmailVerificationState());

  // MARK: - action

  void onActionPressed(
    void Function({
      required void Function({String? errorCode}) onActionDone,
    }) onActionPressed, {
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onSuccess,
  }) {
    state = state.copyWith(isLoading: true);
    onActionPressed(
      onActionDone: ({String? errorCode}) {
        _onActionDone(
          errorCode: errorCode,
          onError: onError,
          onSuccess: onSuccess,
        );
      },
    );
  }

  void _onActionDone({
    String? errorCode,
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onSuccess,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorCode != null) {
      final error = FirebaseAuthFlowError.fromCode(errorCode);
      onError(error: error);
      return;
    }
    onSuccess();
  }

  // MARK: - check verification

  void onCheckVerificationPressed(
    void Function({
      required void Function({String? errorCode, bool? isEmailVerified})
          onCheckDone,
    }) onCheckVerificationPressed, {
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: true);
    onCheckVerificationPressed(
      onCheckDone: ({String? errorCode, bool? isEmailVerified}) {
        _onCheckDone(
          errorCode: errorCode,
          isEmailVerified: isEmailVerified,
          onError: onError,
          onLoggedIn: onLoggedIn,
        );
      },
    );
  }

  void _onCheckDone({
    String? errorCode,
    bool? isEmailVerified,
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorCode != null) {
      final error = FirebaseAuthFlowError.fromCode(errorCode);
      onError(error: error);
      return;
    }
    if (isEmailVerified == true) {
      onLoggedIn();
    } else {
      // TODO: jit na email verif page
      print('neni verified');
    }
  }

  // MARK: - log out

  void onLogoutPressed(
    void Function({
      required void Function({String? errorCode}) onLogoutDone,
    }) onLogoutPressed, {
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onLoggedOut,
  }) {
    state = state.copyWith(isLoading: true);
    onLogoutPressed(
      onLogoutDone: ({String? errorCode}) {
        _onLoggedOut(
          errorCode: errorCode,
          onError: onError,
          onLoggedOut: onLoggedOut,
        );
      },
    );
  }

  void _onLoggedOut({
    String? errorCode,
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onLoggedOut,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorCode != null) {
      final error = FirebaseAuthFlowError.fromCode(errorCode);
      onError(error: error);
      return;
    }
    // TODO: jit na login page
    onLoggedOut();
  }
}
