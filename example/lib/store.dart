import 'package:flutter/services.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

Future<GroundPlanModel> loadStoreGroundPlan() async {
  // final localPath = await getApplicationDocumentsDirectory();
  final yaml = await rootBundle.loadString('assets/store_groundplan.yaml');
  return GroundPlanModel.fromYaml(yaml);
}
