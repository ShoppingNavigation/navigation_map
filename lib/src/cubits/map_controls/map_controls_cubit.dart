import 'package:bloc/bloc.dart';

part 'map_controls_state.dart';

class MapControlsCubit extends Cubit<MapControlsState> {
  MapControlsCubit() : super(const ChangeZoomState(zoom: 1)) {
    zoom(3);
  }

  /// changes the zoom level
  /// max value for zoom is 3, min is 0.5
  void zoom(double zoom) {
    emit(ChangeZoomState(zoom: (state.zoom + zoom).clamp(0.5, 3)));
  }
}
