import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

abstract class UserDataProvider {
  Future<Stream<Vector2>> getPosition();
}

class FakeUserDataProvider extends UserDataProvider {
  @override
  Future<Stream<Vector2>> getPosition() {
    return Future.value(Stream<Vector2>.periodic(const Duration(milliseconds: 100), _getNextStatefulPosition));
  }

  final Vector2 _maxValues = Vector2(40, 60);
  final Vector2 _offset = Vector2(20, 0);
  Vector2 _previousPosition = Vector2(20, 0);
  double _currentStepDirection = 0.5;
  Vector2 _getNextStatefulPosition(int _) {
    double nextY = _previousPosition.y + _currentStepDirection;
    if (nextY > _maxValues.y) {
      _currentStepDirection = -_currentStepDirection;
      nextY += 2 * _currentStepDirection;
    } else if (nextY < 0) {
      _currentStepDirection = -_currentStepDirection;
      nextY += 2 * _currentStepDirection;
    }

    _previousPosition = Vector2(_yValue(nextY, _offset.x), nextY);
    return _previousPosition;
  }

  double _yValue(double x, double offset) => offset + 9 * sin(x * (1 / 10));
}

class GpsUserDataProvider extends UserDataProvider {
  @override
  Future<Stream<Vector2>> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    final baseCoordinates = groundPlanCubit.state.groundPlan.anchorCoordinates;
    return Geolocator.getPositionStream().map((event) {
      var x = Geolocator.distanceBetween(0, event.longitude, 0, baseCoordinates.x) * 10;
      var y = Geolocator.distanceBetween(event.latitude, 0, baseCoordinates.y, 0) * 10;

      print('current pos ($x / $y)');
      return Vector2(x, y);
    });
  }
}
