import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_navigation_map/src/utils/user_data_provider.dart';
import 'package:store_navigation_map/src/utils/user_graph_mapper.dart';

import '../../../store_navigation_map.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserGraphMapper _ugm;
  final UserDataProvider _userDataProvider = GpsUserDataProvider();

  UserCubit(NavigationGraph<UiNode> graph)
      : _ugm = UserGraphMapper(graph),
        super(UserInitial()) {
    _init();
  }

  void _init() async {
    var stream = await _userDataProvider.getPosition();
    stream.listen((event) {
      emit(UserPositionSet(position: event, mappingResult: _ugm.closestPointOnEdge(event)));
    });
  }
}
