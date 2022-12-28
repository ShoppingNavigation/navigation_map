import 'package:store_navigation_map/store_navigation_map.dart';

class UgmResult {
  final bool found;
  final Vector2? closestPoint;
  final Vector2? closestConnection;
  final Vector2? secondConnection;

  UgmResult({required this.found, this.closestPoint, this.closestConnection, this.secondConnection});

  static get empty => UgmResult(found: false);
}

/// !statefull! mapper from the absolute user position to one on the edge
class UserGraphMapper {
  final NavigationGraph<UiNode> graph;
  final double secondBoost;

  UserGraphMapper(this.graph, {this.secondBoost = 1 / 2});

  MapEntry<UiNode, double>? previousSecond;

  /// calculates the closest point on any edge of [graph] for the provided positon
  UgmResult closestPointOnEdge(Vector2 from) {
    final stopwatch = Stopwatch()..start();
    final distances = _calculateDistances(from).entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    if (distances.isEmpty) {
      _reportDebugValues(double.infinity, stopwatch);
      _reportFound(false);
      return UgmResult(found: false);
    }
    final adjacentNodesToClosestNode = graph.getAdjacentTNodes(distances.first.key);
    if (adjacentNodesToClosestNode.isEmpty) {
      _reportDebugValues(double.infinity, stopwatch);
      _reportFound(false);
      return UgmResult(found: false);
    }

    final closestConnection = distances.first.key.position;
    final distancesToOnlyAdjacent =
        distances.where((element) => adjacentNodesToClosestNode.containsKey(element.key)).toList();

    Vector2? closestPoint;
    Vector2? secondConnection;
    int secondConnectionIndex = 0;
    for (var possibleSecondConnection in distancesToOnlyAdjacent) {
      closestPoint = _closestPointOnVectorRay(
        closestConnection,
        possibleSecondConnection.key.position,
        from,
      );
      
      secondConnectionIndex++;
      if (closestPoint != null) {
        secondConnection = possibleSecondConnection.key.position;
        break;
      }
    }
    
    if (closestPoint == null) {
      _reportFound(false);
      return UgmResult(found: false);
    }
    
    _reportDebugValues(from.distanceTo(closestPoint), stopwatch);
    assert(!closestPoint.isNaN && !closestPoint.isInfinite, 'Must be finite: $closestPoint');
    assert(!closestConnection.isNaN && !closestConnection.isInfinite, 'Must be finite: $closestConnection');
    assert(!secondConnection!.isNaN && !secondConnection.isInfinite, 'Must be finite: $secondConnection');
    debugCubit?.addDebugValue('UGM_Closest', closestConnection);
    debugCubit?.addDebugValue('UGM_Second', secondConnection);
    debugCubit?.addDebugValue('UGM_SecondIndex', secondConnectionIndex);
    _reportFound(true);
    return UgmResult(
      found: true,
      closestPoint: closestPoint,
      closestConnection: closestConnection,
      secondConnection: secondConnection,
    );
  }

  Vector2? _closestPointOnVectorRay(Vector2 positionFirst, Vector2 positionSecond, Vector2 from) {
    final directionVector = positionFirst - positionSecond;
    // orthogonal vectors are vector where v1 * v2 = 0
    final orthogonalVector = Vector2(directionVector.y, -directionVector.x);

    final edge = _VectorRay(positionFirst, directionVector);
    final edgeFrom = _VectorRay(from, orthogonalVector);
    final result = edge.getIntersectionPoint(edgeFrom);
    return result;
  }

  /// calculates the closest node
  /// ignores the edges (distance between two vectors rather than between two nodes)
  Map<UiNode, double> _calculateDistances(Vector2 from) {
    final result = <UiNode, double>{};
    for (final node in graph.nodes) {
      result[node] = node.position.distanceTo(from);
    }

    return result;
  }

  int currentStep = 0;
  void _reportDebugValues(double error, Stopwatch sw) {
    debugCubit?.addDebugValue('UGM_Error', error.abs());
    debugCubit?.addDebugValue('UGM_Time', sw.elapsed.inMicroseconds / 1000.0);
    debugCubit?.addDebugValue('UGM_Step', currentStep++);
  }

  void _reportFound(bool found) {
    debugCubit?.addDebugValue('UGM_Found', found);
  }
}

/// stolen from https://github.com/starteNCS/inside, which is javascript. so there are a few adjustments
class _VectorRay {
  final Vector2 location;
  final Vector2 direction;

  const _VectorRay(this.location, this.direction);

  /// Calculates the multiples of both direction Vectors needed to find the intersection point
  /// @param other The Vector ray to search an intersection with
  /// @returns r (0): multiple of this direction vector, t (1): multiple of other direction vector
  ///
  List<double> getMultiplesOfDirectionVectorsForIntersection(_VectorRay other) {
    final dividendT = -(location.x * other.direction.y -
        location.y * other.direction.x +
        other.direction.x * other.location.y -
        other.direction.y * other.location.x);
    final divisorT = direction.x * other.direction.y - direction.y * other.direction.x;

    final dividendR = direction.x * (location.y - other.location.y) - direction.y * (location.x - other.location.x);
    final divisorR = direction.x * other.direction.y - direction.y * other.direction.x;

    return [dividendT / divisorT, dividendR / divisorR];
  }

  /// Calculates the intersectionpoint of two vector rays
  /// @param other The Vector ray to search the intersectionpoint with
  ///@returns Vector2 if there is an intersection, undefined is there isnt
  Vector2? getIntersectionPoint(_VectorRay other) {
    final multiples = getMultiplesOfDirectionVectorsForIntersection(other);

    if (!_isCorrectNumber(multiples[0]) || !_isCorrectNumber(multiples[1])) {
      return null;
    }

    final multiplePointOne = location + (direction * multiples[0]);
    final multiplePointTwo = other.location + (other.direction * multiples[1]);
    if (_isPointOnSection(multiplePointOne)) {
      return multiplePointOne;
    } else if (_isPointOnSection(multiplePointTwo)) {
      return multiplePointTwo;
    } else {
      return null;
    }
  }

  /// checks if a given point is on the base section of the ray
  /// https://stackoverflow.com/questions/11907947/how-to-check-if-a-point-lies-on-a-line-between-2-other-points
  bool _isPointOnSection(Vector2 point) {
    final rayPointOne = location;
    final rayPointTwo = location + direction;

    final dxc = point.x - rayPointOne.x;
    final dyc = point.y - rayPointOne.y;
    final dxl = rayPointTwo.x - rayPointOne.x;
    final dyl = rayPointTwo.y - rayPointOne.y;
    final cross = dxc * dyl - dyc * dxl;

    if (cross.abs() > 0.05) {
      return false;
    }

    if (dxl.abs() >= dyl.abs()) {
      return dxl > 0
          ? rayPointOne.x <= point.x && point.x <= rayPointTwo.x
          : rayPointTwo.x <= point.x && point.x <= rayPointOne.x;
    } else {
      return dyl > 0
          ? rayPointOne.y <= point.y && point.y <= rayPointTwo.y
          : rayPointTwo.y <= point.y && point.y <= rayPointOne.y;
    }
  }

  /// Calculates in which direction the vector ray is facing
  /// @returns: 1 -> Ray is facing upwards (towards positive y)
  ///           -1 -> Ray is facing downwards (towards negative y)
  ///           undefined -> illegal operation, ray may not intersect more than one time
  int? getDirection() {
    if (direction.y == 0) {
      return null;
    }

    return direction.y > 0 ? 1 : -1;
  }

  bool _isCorrectNumber(double toCheck) {
    return !toCheck.isNaN || !toCheck.isInfinite;
  }
}
