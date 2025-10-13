import 'package:firebase_auth_flow/firebase_auth_flow.dart';
import 'package:firebase_auth_flow/src/core/providers/core_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coreProvider = NotifierProvider<CoreNotifier, CoreState>(
  CoreNotifier.new,
);

class CoreNotifier extends Notifier<CoreState> {
  @override
  CoreState build() => CoreState();

  void setState(FirebaseAuthFlowState toState) {
    state = state.copyWith(flowState: toState);
  }
}
