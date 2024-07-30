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
