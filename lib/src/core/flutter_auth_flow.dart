import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/providers/core_provider.dart';
import 'package:flutter_auth_flow/src/features/email_verification_page/email_verification_page.dart';
import 'package:flutter_auth_flow/src/features/login_page/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlutterAuthFlow extends ConsumerStatefulWidget {
  const FlutterAuthFlow(this.dep, {required this.state, super.key});

  /// FlutterAuthFlow dependencies
  final FlutterAuthFlowDependencies dep;

  /// FlutterAuthFlow state
  final FlutterAuthFlowState state;

  @override
  FlutterAuthFlowViewState createState() => FlutterAuthFlowViewState();
}

class FlutterAuthFlowViewState extends ConsumerState<FlutterAuthFlow> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(coreProvider.notifier).setState(widget.state);
    });
  }

  @override
  Widget build(BuildContext context) {
    ConsumerWidget getPage() {
      switch (ref.watch(coreProvider).flowState) {
        case FlutterAuthFlowState.login:
          return LoginPage(widget.dep);
        case FlutterAuthFlowState.emailVerification:
          return EmailVerificationPage(widget.dep);
      }
    }

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
        child: getPage(),
      ),
    );
  }
}
