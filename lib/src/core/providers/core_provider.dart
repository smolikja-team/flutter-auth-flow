import 'package:firebase_auth_flow/firebase_auth_flow.dart';
import 'package:firebase_auth_flow/src/core/providers/core_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coreProvider = StateNotifierProvider<CoreNotifier, CoreState>(
  (ref) => CoreNotifier(),
);

class CoreNotifier extends StateNotifier<CoreState> {
  CoreNotifier() : super(CoreState());

  void setState(FirebaseAuthFlowState toState) {
    state = state.copyWith(flowState: toState);
  }
}
