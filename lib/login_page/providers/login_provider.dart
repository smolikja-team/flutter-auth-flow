import 'package:firebase_auth_flow/login_page/providers/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(),
);

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState()) {
    // _setListener();
  }

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
    }) onLoginPressed,
  ) {
    state = state.copyWith(isLoading: true);
    onLoginPressed(
      email: state.email,
      password: state.password,
      onLoginDone: _onLoginDone,
    );
  }

  void onRegisterPressed(
    void Function({
      required String email,
      required String password,
      required void Function({String? errorCode}) onRegisterDone,
    }) onRegisterPressed,
  ) {
    if (state.password == state.passwordConf) {
      state = state.copyWith(isLoading: true);
      onRegisterPressed(
        email: state.email,
        password: state.password,
        onRegisterDone: _onRegisterDone,
      );
    } else {
      // TODO: hesla se neshoduji
    }
  }

  void _onLoginDone({String? errorCode}) {
    state = state.copyWith(isLoading: false);
    print("=== login succeeded $errorCode"); // TODO: loca
  }

  void _onRegisterDone({String? errorCode}) {
    state = state.copyWith(isLoading: false);
    print("=== register succeeded $errorCode"); // TODO: loca
  }

  // void _setListener() {
  //   FirebaseAuth.instance.userChanges().listen((User? user) {
  //     if (user == null) {
  //       Logging.log.info(
  //         '$runtimeType -> _setListener: User is currently signed out!',
  //       );
  //       state = state.copyWith(isLoggedIn: false);
  //     } else {
  //       Logging.log.info('$runtimeType -> _setListener: User is signed in!');
  //       state = state.copyWith(isLoggedIn: true);
  //     }
  //   });
  // }
}
