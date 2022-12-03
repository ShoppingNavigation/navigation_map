import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class UserGraphMapper {
  final NavigationGraph<UiNode> graph;

  const UserGraphMapper(this.graph);

  /// calculates the closest point on any edge of [graph] for the provided positon
  Vector2 closestPointOnEdge(Vector2 from) {
    final distances = _calculateDistances(from).entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    final adjacentNodesToClosestNode = graph.getAdjacentTNodes(distances.first.key);

    final distancesToOnlyAdjacent = distances.where((element) => adjacentNodesToClosestNode.containsKey(element.key));

    return _closestPointOnVectorRay(
          distances.first.key.position,
          distancesToOnlyAdjacent.first.key.position,
          from,
        ) ??
        Vector2.zero();
  }

  Vector2? _closestPointOnVectorRay(Vector2 positionFirst, Vector2 positionSecond, Vector2 from) {
    final directionVector = positionFirst - positionSecond;
    // orthogonal vectors are vector where v1 * v2 = 0
    final orthogonalVector = Vector2(directionVector.y, -directionVector.x);

    final edge = _VectorRay(positionFirst, directionVector);
    final edgeFrom = _VectorRay(from, orthogonalVector);
    return edge.getIntersectionPoint(edgeFrom);
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

    return location + (direction * multiples[0]);
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
}
