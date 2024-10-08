import 'package:firebase_auth_flow/firebase_auth_flow.dart';
import 'package:firebase_auth_flow/src/core/widgets/main_scaffold.dart';
import 'package:firebase_auth_flow/src/features/email_verification_page/email_verification_page_content.dart';
import 'package:firebase_auth_flow/src/features/email_verification_page/providers/email_verification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationPage extends ConsumerWidget {
  const EmailVerificationPage(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(emailVerificationProvider).isLoading;

    return MainScaffold(
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
