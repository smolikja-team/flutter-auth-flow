import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/widgets/main_scaffold.dart';
import 'package:flutter_auth_flow/src/features/login_page/login_page_content.dart';
import 'package:flutter_auth_flow/src/features/login_page/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage(this.dep, {super.key});

  final AuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginProvider).isLoading;

    return MainScaffold(
      backgroundColor: dep.colorPrimary,
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
    );
  }
}
