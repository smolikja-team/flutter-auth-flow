import 'package:firebase_auth_flow/core/firebase_auth_flow_error.dart';
import 'package:firebase_auth_flow/login_page/providers/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState());

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String newPass) {
    state = state.copyWith(password: newPass);
  }

  void setPasswordConf(String newPass) {
    state = state.copyWith(passwordConf: newPass);
  }

  void switchToRegister() {
    state = state.copyWith(isTypeLogin: false);
  }

  void switchToLogin() {
    state = state.copyWith(isTypeLogin: true);
  }

  void onLoginPressed(
    void Function({
      required String email,
      required String password,
      required void Function({String? errorCode}) onLoginDone,
    }) onLoginPressed, {
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: true);
    onLoginPressed(
      email: state.email,
      password: state.password,
      onLoginDone: ({String? errorCode}) {
        _onLoginDone(
          errorCode: errorCode,
          onError: onError,
          onLoggedIn: onLoggedIn,
        );
      },
    );
  }

  void onRegisterPressed(
    void Function({
      required String email,
      required String password,
      required void Function({String? errorCode}) onRegisterDone,
    }) onRegisterPressed, {
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onRegistered,
  }) {
    if (state.password == state.passwordConf) {
      state = state.copyWith(isLoading: true);
      onRegisterPressed(
        email: state.email,
        password: state.password,
        onRegisterDone: ({String? errorCode}) {
          _onRegisterDone(
            errorCode: errorCode,
            onError: onError,
            onRegistered: onRegistered,
          );
        },
      );
    } else {
      onError(error: FirebaseAuthFlowError.passwordNotMatching);
    }
  }

  void _onLoginDone({
    String? errorCode,
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onLoggedIn,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorCode != null) {
      final error = FirebaseAuthFlowError.fromCode(errorCode);
      onError(error: error);
      return;
    }
    onLoggedIn();
  }

  void _onRegisterDone({
    String? errorCode,
    required void Function({required FirebaseAuthFlowError error}) onError,
    required void Function() onRegistered,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorCode != null) {
      final error = FirebaseAuthFlowError.fromCode(errorCode);
      onError(error: error);
      return;
    }
    onRegistered();
  }
}
