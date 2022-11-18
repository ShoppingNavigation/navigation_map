import 'package:bloc/bloc.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit() : super(GraphState(NavigationGraph(nodes: [])));

  void setNewGraph(NavigationGraph<UiNode> graph) {
    emit(GraphState(graph));
  }
}
