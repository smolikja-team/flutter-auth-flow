import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/widgets/main_scaffold.dart';
import 'package:flutter_auth_flow/src/features/email_verification_page/email_verification_page_content.dart';
import 'package:flutter_auth_flow/src/features/email_verification_page/providers/email_verification_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationPage extends ConsumerWidget {
  const EmailVerificationPage(this.dep, {super.key});

  final FlutterAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(emailVerificationProvider).isLoading;

    return MainScaffold(
      backgroundColor: dep.colorPrimary,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AbsorbPointer(
            absorbing: isLoading,
            child: EmailVerificationPageContent(dep),
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
