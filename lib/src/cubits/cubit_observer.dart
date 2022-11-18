import 'package:bloc/bloc.dart';
import 'package:store_navigation_map/src/cubits/debug/debug_cubit.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class DebugObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    debugCubit?.addLog('New cubit created: ${bloc.runtimeType}');

    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is DebugCubit) {
      return;
    }
    debugCubit?.addLog('OBS: ${change.nextState}');
  }
}
