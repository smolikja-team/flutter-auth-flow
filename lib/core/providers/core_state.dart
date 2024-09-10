import 'package:firebase_auth_flow/core/firebase_auth_flow_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'core_state.freezed.dart';

@freezed
class CoreState with _$CoreState {
  factory CoreState({
    @Default(FirebaseAuthFlowState.login) FirebaseAuthFlowState flowState,
  }) = _CoreState;
}
