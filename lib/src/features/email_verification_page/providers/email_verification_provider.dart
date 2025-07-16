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
      required void Function({FlutterAuthFlowError? error}) onActionDone,
    }) onActionPressed, {
    required void Function({required FlutterAuthFlowError error}) onError,
    required void Function() onSuccess,
  }) {
    state = state.copyWith(isLoading: true);
    onActionPressed(
      onActionDone: ({FlutterAuthFlowError? error}) {
        _onActionDone(
          error: error,
          onError: onError,
          onSuccess: onSuccess,
        );
      },
    );
  }

  void _onActionDone({
    FlutterAuthFlowError? error,
    required void Function({required FlutterAuthFlowError error}) onError,
    required void Function() onSuccess,
  }) {
    state = state.copyWith(isLoading: false);
    if (error != null) {
      onError(error: error);
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
      required void Function({FlutterAuthFlowError? error, bool? isEmailVerified})
          onCheckDone,
    }) onCheckVerificationPressed, {
    required void Function({required FlutterAuthFlowError error}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: true);
    onCheckVerificationPressed(
      onCheckDone: ({FlutterAuthFlowError? error, bool? isEmailVerified}) {
        _onCheckDone(
          error: error,
          isEmailVerified: isEmailVerified,
          onError: onError,
          onLoggedIn: onLoggedIn,
        );
      },
    );
  }

  void _onCheckDone({
    FlutterAuthFlowError? error,
    bool? isEmailVerified,
    required void Function({required FlutterAuthFlowError error}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: false);
    if (error != null) {
      onError(error: error);
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
      required void Function({FlutterAuthFlowError? error}) onLogoutDone,
    }) onLogoutPressed, {
    required void Function({required FlutterAuthFlowError error}) onError,
    required void Function() onLoggedOut,
  }) {
    state = state.copyWith(isLoading: true);
    onLogoutPressed(
      onLogoutDone: ({FlutterAuthFlowError? error}) {
        _onLoggedOut(
          error: error,
          onError: onError,
          onLoggedOut: onLoggedOut,
        );
      },
    );
  }

  void _onLoggedOut({
    FlutterAuthFlowError? error,
    required void Function({required FlutterAuthFlowError error}) onError,
    required void Function() onLoggedOut,
  }) {
    state = state.copyWith(isLoading: false);
    if (error != null) {
      onError(error: error);
      return;
    }
    ref.read(coreProvider.notifier).setState(FlutterAuthFlowState.login);
    onLoggedOut();
  }
}
