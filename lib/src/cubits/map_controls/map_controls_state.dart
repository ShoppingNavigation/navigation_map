part of 'map_controls_cubit.dart';

abstract class MapControlsState {
  final double zoom;
  final double userZoomValue;
  final double additionalZoom;

  final Vector2 startupPosition;

  const MapControlsState(
      {required this.zoom, required this.additionalZoom, required this.userZoomValue, required this.startupPosition});

  Vector2 get scale => Vector2.all(zoom);

  MapControlsState changeZoom({required double zoom, required double userZoom}) =>
      ChangeZoomState(
      zoom: zoom, additionalZoom: additionalZoom, userZoomValue: userZoom, startupPosition: startupPosition);
}

class InitMapControlsState extends MapControlsState {
  const InitMapControlsState({
    required super.zoom,
    required super.additionalZoom,
    required super.userZoomValue,
    required super.startupPosition,
  });
}

class ChangeZoomState extends MapControlsState {
  const ChangeZoomState({
    required super.zoom,
    required super.additionalZoom,
    required super.userZoomValue,
    required super.startupPosition,
  });

  @override
  String toString() => 'Change Zoom: $zoom';
}
