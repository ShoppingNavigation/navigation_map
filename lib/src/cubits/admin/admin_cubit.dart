import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit({required bool active, required void Function(UiNode) onShelfSelected})
      : super(
          active ? AdminInitial(onShelfSelected: onShelfSelected) : const NoAdminInitial(),
        );

  void selectShelf(GroundPlanShelfModel shelf) {
    if (state is NoAdminInitial) {
      return;
    }

    final adminState = state as AdminInitial;
    adminState.onShelfSelected(shelf.connector.node);
    emit(AdminShelfSelected(onShelfSelected: adminState.onShelfSelected, selectedShelf: shelf));
  }
}
