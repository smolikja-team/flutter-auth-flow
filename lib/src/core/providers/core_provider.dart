import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:flutter_auth_flow/src/core/providers/core_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coreProvider = NotifierProvider<CoreNotifier, CoreState>(
  CoreNotifier.new,
);

class CoreNotifier extends Notifier<CoreState> {
  @override
  CoreState build() => CoreState();

  void setState(FlutterAuthFlowState toState) {
    state = state.copyWith(flowState: toState);
  }
}
