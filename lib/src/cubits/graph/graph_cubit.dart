import 'package:bloc/bloc.dart';
import 'package:store_navigation_graph/store_navigation_graph.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit() : super(GraphState(NavigationGraph(nodes: [])));

  void setNewGraph(NavigationGraph graph) {
    emit(GraphState(graph));
  }
}
