import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/providers/core_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coreProvider = StateNotifierProvider<CoreNotifier, CoreState>(
  (ref) => CoreNotifier(),
);

class CoreNotifier extends StateNotifier<CoreState> {
  CoreNotifier() : super(CoreState());

  void setState(AuthFlowState toState) {
    state = state.copyWith(flowState: toState);
  }
}
