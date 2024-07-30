import 'package:firebase_auth_flow/login_page/presentation/auth_page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FirebaseAuthFlowProvider { email }

class FirebaseAuthFlowDependencies {
  const FirebaseAuthFlowDependencies({
    required this.provider,
    required this.activityIndicator,
    this.disabledOpacity = 0.65,
    this.borderRadius = 12.0,
  });

  final FirebaseAuthFlowProvider provider;
  final Widget activityIndicator;
  final double disabledOpacity;
  final double borderRadius;
  // TODO: color scheme
}

class FirebaseAuthFlow extends ConsumerStatefulWidget {
  const FirebaseAuthFlow(this.dep, {super.key});

  /// FirebaseAuthFlow dependencies
  final FirebaseAuthFlowDependencies dep;

  @override
  ConsumerState<FirebaseAuthFlow> createState() => _FirebaseAuthFlowState();
}

class _FirebaseAuthFlowState extends ConsumerState<FirebaseAuthFlow> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            AbsorbPointer(
              absorbing: false, // TODO: z provideru
              child: AuthPageContent(widget.dep),
            ),
            if (true)
              Center(child: widget.dep.activityIndicator), // TODO: z provideru
          ],
        ),
      ),
    );
  }
}
