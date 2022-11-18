part of 'map_controls_cubit.dart';

abstract class MapControlsState {
  final double zoom;

  const MapControlsState({required this.zoom});
}

class ChangeZoomState extends MapControlsState {
  const ChangeZoomState({required super.zoom});

  @override
  String toString() => 'Change Zoom: $zoom';
}
