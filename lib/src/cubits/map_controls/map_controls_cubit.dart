import 'package:bloc/bloc.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

part 'map_controls_state.dart';

class MapControlsCubit extends Cubit<MapControlsState> {
  MapControlsCubit({required double additionalZoom, Vector2? startupPosition})
      : super(InitMapControlsState(
          zoom: 1 + additionalZoom,
          additionalZoom: additionalZoom,
          userZoomValue: 1,
          startupPosition: startupPosition ?? Vector2.all(0),
        ));

  /// changes the zoom level
  /// max value for zoom is 3, min is 0.5
  void zoom(double zoom) {
    final double userZoom = (state.userZoomValue + zoom).clamp(0.5, 3);
    final realZoom = userZoom * state.additionalZoom;
    emit(state.changeZoom(userZoom: userZoom, zoom: realZoom));
  }
}
