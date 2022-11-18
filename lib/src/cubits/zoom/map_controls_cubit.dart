import 'dart:math';

import 'package:bloc/bloc.dart';

part 'map_controls_state.dart';

class MapControlsCubit extends Cubit<MapControlsState> {
  MapControlsCubit() : super(const ChangeZoomState(zoom: 1));

  /// increases the zoom level
  /// max value for zoom is 2
  void increaseZoomByPercent(double zoom) {
    emit(ChangeZoomState(zoom: min(state.zoom + zoom, 2)));
  }

  /// decreases the zoom level
  /// min value for zoom is .5
  void decreaseZoomByPercent(double zoom) {
    emit(ChangeZoomState(zoom: max(state.zoom - zoom, 0.5)));
  }

  @override
  void onChange(Change<MapControlsState> change) {
    super.onChange(change);

    // todo: write to debug cubit
  }
}
