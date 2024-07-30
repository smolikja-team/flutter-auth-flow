import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthFlow extends ConsumerWidget {
  const FirebaseAuthFlow(this.dep, {super.key});

  /// FirebaseAuthFlow dependencies
  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: tady bude switch pro jednotlivy stavy flow
    return ProviderScope(child: LoginPage(dep));
  }
}
