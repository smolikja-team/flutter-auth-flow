import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/providers/core_provider.dart';
import 'package:flutter_auth_flow/src/features/email_verification_page/providers/email_verification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailVerificationProvider =
    StateNotifierProvider<EmailVerificationNotifier, EmailVerificationState>(
  EmailVerificationNotifier.new,
);

class EmailVerificationNotifier extends StateNotifier<EmailVerificationState> {
  EmailVerificationNotifier(this.ref) : super(EmailVerificationState());

  final Ref ref;

  // MARK: - action

  /// Called when the user presses the action button.
  void onActionPressed(
    void Function({
      required void Function({String? errorMessage}) onActionDone,
    }) onActionPressed, {
    required void Function({required String errorMessage}) onError,
    required void Function() onSuccess,
  }) {
    state = state.copyWith(isLoading: true);
    onActionPressed(
      onActionDone: ({String? errorMessage}) {
        _onActionDone(
          errorMessage: errorMessage,
          onError: onError,
          onSuccess: onSuccess,
        );
      },
    );
  }

  void _onActionDone({
    String? errorMessage,
    required void Function({required String errorMessage}) onError,
    required void Function() onSuccess,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorMessage != null) {
      onError(errorMessage: errorMessage);
      return;
    }
    onSuccess();
  }

  // MARK: - check verification

  /// Called when the user presses the check verification button.
  /// This will check if the email is verified.
  /// If the email is verified, the user will be logged in.
  /// If the email is not verified, the user will be redirected to the email verification page.
  void onCheckVerificationPressed(
    void Function({
      required void Function({String? errorMessage, bool? isEmailVerified})
          onCheckDone,
    }) onCheckVerificationPressed, {
    required void Function({required String errorMessage}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: true);
    onCheckVerificationPressed(
      onCheckDone: ({String? errorMessage, bool? isEmailVerified}) {
        _onCheckDone(
          errorMessage: errorMessage,
          isEmailVerified: isEmailVerified,
          onError: onError,
          onLoggedIn: onLoggedIn,
        );
      },
    );
  }

  void _onCheckDone({
    String? errorMessage,
    bool? isEmailVerified,
    required void Function({required String errorMessage}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorMessage != null) {
      onError(errorMessage: errorMessage);
      return;
    }
    if (isEmailVerified == true) {
      onLoggedIn();
    } else {
      ref
          .read(coreProvider.notifier)
          .setState(FlutterAuthFlowState.emailVerification);
    }
  }

  // MARK: - log out

  /// Called when the user presses the log out button.
  /// This will log out the user.
  /// If the log out is successful, the user will be redirected to the login page.
  void onLogoutPressed(
    void Function({
      required void Function({String? errorMessage}) onLogoutDone,
    }) onLogoutPressed, {
    required void Function({required String errorMessage}) onError,
    required void Function() onLoggedOut,
  }) {
    state = state.copyWith(isLoading: true);
    onLogoutPressed(
      onLogoutDone: ({String? errorMessage}) {
        _onLoggedOut(
          errorMessage: errorMessage,
          onError: onError,
          onLoggedOut: onLoggedOut,
        );
      },
    );
  }

  void _onLoggedOut({
    String? errorMessage,
    required void Function({required String errorMessage}) onError,
    required void Function() onLoggedOut,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorMessage != null) {
      onError(errorMessage: errorMessage);
      return;
    }
    ref.read(coreProvider.notifier).setState(FlutterAuthFlowState.login);
    onLoggedOut();
  }
}
