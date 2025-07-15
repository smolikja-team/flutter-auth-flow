import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/providers/core_provider.dart';
import 'package:flutter_auth_flow/src/features/login_page/providers/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this.ref) : super(LoginState());

  final Ref ref;

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

  // MARK: - register

  /// Called when the user presses the register button.
  /// This will register the user.
  /// If the registration is successful, the user will be redirected to the email verification page.
  void onRegisterPressed(
    void Function({
      required String email,
      required String password,
      required void Function({String? errorCode}) onRegisterDone,
    }) onRegisterPressed, {
    required void Function({required AuthFlowError error}) onError,
  }) {
    if (state.password == state.passwordConf) {
      state = state.copyWith(isLoading: true);
      onRegisterPressed(
        email: state.email,
        password: state.password,
        onRegisterDone: ({String? errorCode}) {
          _onRegisterDone(errorCode: errorCode, onError: onError);
        },
      );
    } else {
      onError(error: AuthFlowError.passwordNotMatching);
    }
  }

  void _onRegisterDone({
    String? errorCode,
    required void Function({required AuthFlowError error}) onError,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorCode != null) {
      final error = AuthFlowError.fromCode(errorCode);
      onError(error: error);
      return;
    }
    ref
        .read(coreProvider.notifier)
        .setState(AuthFlowState.emailVerification);
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
      required void Function({String? errorCode, bool? isEmailVerified})
          onLoginDone,
    }) onLoginPressed, {
    required void Function({required AuthFlowError error}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: true);
    onLoginPressed(
      email: state.email,
      password: state.password,
      onLoginDone: ({String? errorCode, bool? isEmailVerified}) {
        _onLoginDone(
          errorCode: errorCode,
          isEmailVerified: isEmailVerified,
          onError: onError,
          onLoggedIn: onLoggedIn,
        );
      },
    );
  }

  void _onLoginDone({
    String? errorCode,
    bool? isEmailVerified,
    required void Function({required AuthFlowError error}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorCode != null) {
      final error = AuthFlowError.fromCode(errorCode);
      onError(error: error);
      return;
    }
    if (isEmailVerified == true) {
      onLoggedIn();
    } else {
      ref
          .read(coreProvider.notifier)
          .setState(AuthFlowState.emailVerification);
    }
  }
}
