part of 'map_controls_cubit.dart';

abstract class MapControlsState {
  final double zoom;
  final double userZoomValue;
  final double additionalZoom;

  const MapControlsState({required this.zoom, required this.additionalZoom, required this.userZoomValue});

  MapControlsState changeZoom({required double zoom, required double userZoom}) =>
      ChangeZoomState(zoom: zoom, additionalZoom: additionalZoom, userZoomValue: userZoom);
}

class InitMapControlsState extends MapControlsState {
  const InitMapControlsState({required super.zoom, required super.additionalZoom, required super.userZoomValue});
}

class ChangeZoomState extends MapControlsState {
  const ChangeZoomState({required super.zoom, required super.additionalZoom, required super.userZoomValue});

  @override
  String toString() => 'Change Zoom: $zoom';
}
