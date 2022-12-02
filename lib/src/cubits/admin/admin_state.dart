part of 'admin_cubit.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class NoAdminInitial extends AdminState {
  const NoAdminInitial() : super();
}

class AdminInitial extends AdminState {
  final void Function(UiNode) onShelfSelected;

  const AdminInitial({required this.onShelfSelected});
}

class AdminShelfSelected extends AdminInitial {
  final GroundPlanShelfModel selectedShelf;

  const AdminShelfSelected({required super.onShelfSelected, required this.selectedShelf});

  @override
  String toString() => 'Selected shelf at node ${selectedShelf.connector.node}';

  @override
  List<Object> get props => [selectedShelf];
}
