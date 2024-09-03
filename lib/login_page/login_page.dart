import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:firebase_auth_flow/login_page/login_page_content.dart';
import 'package:firebase_auth_flow/login_page/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginProvider).isLoading;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AbsorbPointer(
            absorbing: isLoading,
            child: LoginPageContent(dep),
          ),
          if (isLoading)
            Center(
              child: dep.activityIndicator,
            ),
        ],
      ),
      backgroundColor:
          dep.colorOnPrimary ?? Theme.of(context).colorScheme.onPrimary,
    );
  }
}
