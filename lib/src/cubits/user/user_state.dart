part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState({
    required this.position,
    required this.mappingResult,
    required this.anchorCoordinates,
    required this.rotation,
  });

  /// the provided position inside the market
  final Vector2 position;

  /// the calculated position on the closest edge of the navigation graph
  final UgmResult mappingResult;

  /// anchor coordinates of the store
  final Vector2 anchorCoordinates;

  /// compass rotation of user (between -pi and pi)
  final double rotation;

  Vector2 get calculatedPosition => mappingResult.found &&
          mappingResult.error! > groundPlanCubit.state.groundPlan.maxUGMError
      ? mappingResult.closestPoint!
      : position;

  @override
  String toString() =>
      "Mapped Position: ${mappingResult.found}, rotation $rotation";

  @override
  List<Object> get props => [position, mappingResult];
}

class UserInitial extends UserState {
  UserInitial({required super.anchorCoordinates})
      : super(
            position: Vector2.zero(),
            mappingResult: UgmResult.empty,
            rotation: 0);
}

class UserPositionSet extends UserState {
  const UserPositionSet({
    required super.position,
    required super.mappingResult,
    required super.anchorCoordinates,
    required super.rotation,
  });

  @override
  String toString() => 'Update user position';
}
