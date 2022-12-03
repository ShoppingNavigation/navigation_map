import 'dart:math';

import 'package:store_navigation_map/store_navigation_map.dart';

abstract class UserDataProvider {
  Stream<Vector2> getPosition();
}

class FakeUserDataProvider extends UserDataProvider {
  @override
  Stream<Vector2> getPosition() {
    return Stream<Vector2>.periodic(const Duration(milliseconds: 1000), _getNextStatefulPosition);
  }

  final Vector2 _maxValues = Vector2(40, 60);
  final Vector2 _offset = Vector2(20, 0);
  Vector2 _previousPosition = Vector2(20, 0);
  double _currentStepDirection = 1;
  Vector2 _getNextStatefulPosition(int _) {
    double nextY = _previousPosition.y + _currentStepDirection;
    if (nextY > _maxValues.y) {
      _currentStepDirection = -1;
      nextY += 2 * _currentStepDirection;
    } else if (nextY < 0) {
      _currentStepDirection = 1;
      nextY += 2 * _currentStepDirection;
    }

    _previousPosition = Vector2(_yValue(nextY, _offset.x), nextY);
    return _previousPosition;
  }

  double _yValue(double x, double offset) => offset + 10 * sin(x * (1 / 10));
}
