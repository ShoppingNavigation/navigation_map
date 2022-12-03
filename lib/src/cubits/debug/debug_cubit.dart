import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store_navigation_map/src/cubits/debug/log_model.dart';

part 'debug_state.dart';

class DebugCubit extends Cubit<DebugState> {
  DebugCubit({required bool canShowDebug}) : super(DebugInitial(canShowDebug: canShowDebug));

  void addDebugValue(String key, dynamic value) {
    emit(state.addDebugValue(key, value));
  }

  void addLog(String message) {
    emit(state.addLog(message));
  }

  void changeVisibility() {
    emit(state.changeVisibility());
  }
}
