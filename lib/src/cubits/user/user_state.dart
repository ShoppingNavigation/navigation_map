part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState({required this.position, required this.mappingResult});

  /// the provided position inside the market
  final Vector2 position;

  /// the calculated position on the closest edge of the navigation graph
  final UgmResult mappingResult;

  @override
  List<Object> get props => [position, mappingResult];
}

class UserInitial extends UserState {
  UserInitial() : super(position: Vector2.zero(), mappingResult: UgmResult.empty);
}

class UserPositionSet extends UserState {
  const UserPositionSet({required super.position, required super.mappingResult});

  @override
  String toString() => 'Update user position';
}
