part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState({required this.position, required this.edgePosition});

  /// the provided position inside the market
  final Vector2 position;

  /// the calculated position on the closest edge of the navigation graph
  final Vector2 edgePosition;

  @override
  List<Object> get props => [position, edgePosition];
}

class UserInitial extends UserState {
  UserInitial() : super(position: Vector2.zero(), edgePosition: Vector2.zero());
}

class UserPositionSet extends UserState {
  const UserPositionSet({required super.position, required super.edgePosition});

  @override
  String toString() => 'Update user position';
}
