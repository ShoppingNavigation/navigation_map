import 'package:store_navigation_map/src/utils/yaml_utils.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';
import 'package:yaml/yaml.dart';

class ShelfCategoryConnector {
  final Vector2 position;
  final CategoryModel category;
  final String nodeId;

  const ShelfCategoryConnector({required this.position, required this.category, required this.nodeId});

  UiNode get node => groundPlanCubit.state.groundPlan.graph.nodes.firstWhere((element) => element.name == nodeId);

  @override
  String toString() => '${category.name} connected to $node';

  static ShelfCategoryConnector fromYaml(YamlMap yaml) {
    assert(yaml.containsKey('position'));
    assert(yaml.containsKey('node'));

    /// todo: make category nullable
    return ShelfCategoryConnector(
      position: vectorFromYaml(yaml['position']),
      category: const CategoryModel(id: 'test', name: 'test', nodeId: 'test'),
      nodeId: yaml['node'],
    );
  }
}
