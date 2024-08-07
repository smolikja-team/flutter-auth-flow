import 'package:firebase_auth_flow/core/firebase_auth_flow_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationPageContent extends ConsumerWidget {
  const EmailVerificationPageContent(this.dep, {super.key});

  final FirebaseAuthFlowDependencies dep;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isTypeLogin = ref.watch(loginProvider).isTypeLogin;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Email není ověřen'),
              const Text(
                'Ověření naleznete na svém emailu.', //Po ověření na emailu, potvrďte
              ),
              const Text(
                'Po ověření na emailu, potvrďte:',
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text(
                  'Potvrdit',
                  style: TextStyle(color: ConstColors.hyperlinkBlue),
                ),
              ),
              TextButton(
                onPressed: () => AuthenticationHelper().sendEmailVerification(),
                child: const Text(
                  'Znovu odeslat',
                  style: TextStyle(color: ConstColors.hyperlinkBlue),
                ),
              ),
              TextButton(
                onPressed: () =>
                    AuthenticationHelper().logOut(context: context),
                child: const Text(
                  'Odhlásit se',
                  style: TextStyle(color: ConstColors.hyperlinkBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
