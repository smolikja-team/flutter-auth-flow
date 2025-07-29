import 'package:flutter_auth_flow/flutter_auth_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'core_state.freezed.dart';

@freezed
class CoreState with _$CoreState {
  factory CoreState({
    @Default(FlutterAuthFlowState.login) FlutterAuthFlowState flowState,
  }) = _CoreState;
}
