import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/core/firebase_auth_flow_state.dart';
import 'package:firebase_auth_flow/email_verification_page/email_verification_page.dart';
import 'package:firebase_auth_flow/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthFlow extends ConsumerWidget {
  const FirebaseAuthFlow(this.dep, {required this.state, super.key});

  /// FirebaseAuthFlow dependencies
  final FirebaseAuthFlowDependencies dep;

  /// FirebaseAuthFlow state
  final FirebaseAuthFlowState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final ConsumerWidget page;
    switch (state) {
      case FirebaseAuthFlowState.login:
        page = LoginPage(dep);
        break;
      case FirebaseAuthFlowState.emailVerification:
        page = EmailVerificationPage(dep);
        break;
    }

    return ProviderScope(child: page);
  }
}
