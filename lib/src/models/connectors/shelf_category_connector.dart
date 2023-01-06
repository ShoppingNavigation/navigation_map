import 'package:store_navigation_map/src/utils/yaml_utils.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';
import 'package:yaml/yaml.dart';

class ShelfCategoryConnector {
  final Vector2 position;

  /// non-final, becuse it is mapped at runtime
  CategoryModel? category;
  final String nodeId;

  ShelfCategoryConnector({required this.position, required this.category, required this.nodeId});

  UiNode get node => groundPlanCubit.state.groundPlan.graph.nodes.firstWhere((element) => element.name == nodeId);
  bool get hasCategoryAssigned => category != null;

  @override
  String toString() => category != null ? '${category!.name} connected to $node' : 'Empty connector to $node';

  static ShelfCategoryConnector fromYaml(YamlMap yaml) {
    assert(yaml.containsKey('position'));
    assert(yaml.containsKey('node'));

    return ShelfCategoryConnector(
      position: vectorFromYaml(yaml['position']),
      category: null,
      nodeId: yaml['node'],
    );
  }
}
