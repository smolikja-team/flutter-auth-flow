import 'package:firebase_auth_flow/firebase_auth_flow.dart';
import 'package:firebase_auth_flow/src/core/providers/core_provider.dart';
import 'package:firebase_auth_flow/src/features/email_verification_page/email_verification_page.dart';
import 'package:firebase_auth_flow/src/features/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthFlow extends ConsumerStatefulWidget {
  const FirebaseAuthFlow(this.dep, {required this.state, super.key});

  /// FirebaseAuthFlow dependencies
  final FirebaseAuthFlowDependencies dep;

  /// FirebaseAuthFlow state
  final FirebaseAuthFlowState state;

  @override
  FirebaseAuthFlowViewState createState() => FirebaseAuthFlowViewState();
}

class FirebaseAuthFlowViewState extends ConsumerState<FirebaseAuthFlow> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(coreProvider.notifier).setState(widget.state);
    });
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(coreProvider).flowState;
    final page = switch (flowState) {
      FirebaseAuthFlowState.login => LoginPage(widget.dep),
      FirebaseAuthFlowState.emailVerification =>
          EmailVerificationPage(widget.dep),
    };

    return ProviderScope(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), // Obrazovka přijde zprava
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        child: page,
      ),
    );
  }
}
