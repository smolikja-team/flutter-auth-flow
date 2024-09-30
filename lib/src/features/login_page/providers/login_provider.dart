import 'package:firebase_auth_flow/src/core/firebase_auth_flow_error.dart';
import 'package:firebase_auth_flow/src/core/firebase_auth_flow_state.dart';
import 'package:firebase_auth_flow/src/core/providers/core_provider.dart';
import 'package:firebase_auth_flow/src/features/login_page/providers/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this.ref) : super(LoginState());

  final Ref ref;

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

  // MARK: - register

  void onRegisterPressed(
    void Function({
      required String email,
      required String password,
      required void Function({String? errorCode}) onRegisterDone,
    }) onRegisterPressed, {
    required void Function({required FirebaseAuthFlowError error}) onError,
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
      onError(error: FirebaseAuthFlowError.passwordNotMatching);
    }
  }

  void _onRegisterDone({
    String? errorCode,
    required void Function({required FirebaseAuthFlowError error}) onError,
  }) {
    state = state.copyWith(isLoading: false);
    if (errorCode != null) {
      final error = FirebaseAuthFlowError.fromCode(errorCode);
      onError(error: error);
      return;
    }
    ref
        .read(coreProvider.notifier)
        .setState(FirebaseAuthFlowState.emailVerification);
  }

  // MARK: - login

  void onLoginPressed(
    void Function({
      required String email,
      required String password,
      required void Function({String? errorCode, bool? isEmailVerified})
          onLoginDone,
    }) onLoginPressed, {
    required void Function({required FirebaseAuthFlowError error}) onError,
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
      ref
          .read(coreProvider.notifier)
          .setState(FirebaseAuthFlowState.emailVerification);
    }
  }
}
