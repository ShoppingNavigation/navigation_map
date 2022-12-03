import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_navigation_map/src/utils/user_data_provider.dart';

import '../../../store_navigation_map.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial()) {
    FakeUserDataProvider().getPosition().listen((event) {
      emit(UserPositionSet(position: event, edgePosition: Vector2.zero()));
    });
  }
}
