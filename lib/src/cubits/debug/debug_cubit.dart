import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'debug_state.dart';

class DebugCubit extends Cubit<DebugState> {
  DebugCubit() : super(DebugInitial());

  void addLog(String message) {
    emit(state.addLog(message));
  }

  void changeVisibility() {
    emit(state.changeVisibility());
  }
}
