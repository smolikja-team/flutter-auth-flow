import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/login_page/login_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: naming - Login page?
class LoginPage extends ConsumerWidget {
  const LoginPage(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AbsorbPointer(
            absorbing: false, // TODO: z provideru pokdu se loaduje
            child: LoginPageContent(dep),
          ),
          if (true)
            Center(
              child: dep.activityIndicator,
            ), // TODO: z provideru pokud se loaduje ukazat loading
        ],
      ),
    );
  }
}
