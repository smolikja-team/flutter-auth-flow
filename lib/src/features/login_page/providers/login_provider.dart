import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/providers/core_provider.dart';
import 'package:flutter_auth_flow/src/features/login_page/providers/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() => LoginState();

  /// Sets the email.
  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  /// Sets the password.
  void setPassword(String newPass) {
    state = state.copyWith(password: newPass);
  }

  /// Sets the password confirmation.
  void setPasswordConf(String newPass) {
    state = state.copyWith(passwordConf: newPass);
  }

  /// Switches to the register page.
  void switchToRegister() {
    state = state.copyWith(isTypeLogin: false);
  }

  /// Switches to the login page.
  void switchToLogin() {
    state = state.copyWith(isTypeLogin: true);
  }

  /// Resets the state to initial values.
  void _resetState() {
    state = LoginState();
  }

  // MARK: - register

  /// Called when the user presses the register button.
  /// This will register the user.
  /// If the registration is successful, the user will be redirected to the email verification page.
  void onRegisterPressed(
    void Function({
      required String email,
      required String password,
      required void Function({String? errorMessage}) onRegisterDone,
    }) onRegisterPressed, {
    required void Function({required String errorMessage}) onError,
    required String passNotMatchingMessage,
  }) {
    if (state.password == state.passwordConf) {
      state = state.copyWith(isLoading: true);
      onRegisterPressed(
        email: state.email,
        password: state.password,
        onRegisterDone: ({String? errorMessage}) {
          _onRegisterDone(errorMessage: errorMessage, onError: onError);
        },
      );
    } else {
      onError(errorMessage: passNotMatchingMessage);
    }
  }

  void _onRegisterDone({
    String? errorMessage,
    required void Function({required String errorMessage}) onError,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorMessage != null) {
      onError(errorMessage: errorMessage);
      return;
    }
    _resetState();
    ref
        .read(coreProvider.notifier)
        .setState(FlutterAuthFlowState.emailVerification);
  }

  // MARK: - login

  /// Called when the user presses the login button.
  /// This will log in the user.
  /// If the login is successful, the user will be redirected to the email verification page if the email is not verified.
  /// If the email is verified, the user will be logged in.
  void onLoginPressed(
    void Function({
      required String email,
      required String password,
      required void Function({
        String? errorMessage,
        bool? isEmailVerified,
      }) onLoginDone,
    }) onLoginPressed, {
    required void Function({required String errorMessage}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: true);
    onLoginPressed(
      email: state.email,
      password: state.password,
      onLoginDone: ({String? errorMessage, bool? isEmailVerified}) {
        _onLoginDone(
          errorMessage: errorMessage,
          isEmailVerified: isEmailVerified,
          onError: onError,
          onLoggedIn: onLoggedIn,
        );
      },
    );
  }

  void _onLoginDone({
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
    _resetState();
    if (isEmailVerified == true) {
      onLoggedIn();
    } else {
      ref
          .read(coreProvider.notifier)
          .setState(FlutterAuthFlowState.emailVerification);
    }
  }

  // MARK: - reset password

  /// Called when the user presses the reset password button.
  /// This will reset the user's password.
  /// If the reset is successful, the user will be shown a success message.
  /// If the reset is unsuccessful, the user will be shown an error message.
  void onResetPasswordPressed(
    void Function({
      required String email,
      required void Function({String? errorMessage}) onResetDone,
    }) onResetPasswordPressed, {
    required void Function({required String errorMessage}) onError,
  }) {
    onResetPasswordPressed(
      email: state.email,
      onResetDone: ({String? errorMessage}) {
        _onResetPasswordDone(
          errorMessage: errorMessage,
          onError: onError,
        );
      },
    );
  }

  void _onResetPasswordDone({
    String? errorMessage,
    required void Function({required String errorMessage}) onError,
  }) {
    if (errorMessage != null) {
      onError(errorMessage: errorMessage);
      return;
    }
  }
}
