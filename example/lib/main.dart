import 'package:example/destination_selector.dart';
import 'package:example/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';

import 'only_graph.dart';
import 'groundplan.dart';

late final GroundPlanModel storeGroundPlan;
const CategoryModel categoryModel =
    CategoryModel(id: 'asdf', name: 'Lecker brot und so', nodeId: 'v7');

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.setup();
  storeGroundPlan = await loadStoreGroundPlan();

  runApp(
    MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xFFBFF5A3))),
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: RoutingCubit()),
          BlocProvider.value(
              value: UserCubit(
                  graph: storeGroundPlan.graph,
                  anchorCoordinates: storeGroundPlan.anchorCoordinates)),
        ],
        child: Example(key: UniqueKey()),
      ),
    ),
  );
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _currentDestination = 2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routingCubit = context.read<RoutingCubit>();

    return Scaffold(
      appBar: AppBar(
          title: const Text('Navigation Map Example'),
          actions: _currentDestination == 1
              ? [
                  IconButton(
                    onPressed: () => context
                        .read<RoutingCubit>()
                        .routeTo(startNode, getranke),
                    icon: const Icon(Icons.route),
                  ),
                  IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) =>
                          DestinationSelector(routingCubit: routingCubit),
                    ),
                    icon: const Icon(Icons.alt_route),
                  )
                ]
              : []),
      // somehow does not work with list lookup
      body: _currentDestination == 0
          ? NavigationMap(
              groundplan: groundPlanOnlyGraph,
              canShowDebug: true,
              key: UniqueKey())
          : _currentDestination == 1
              ? NavigationMap(
                  groundplan: groundPlan,
                  canShowDebug: true,
                  adminActive: true,
                  onShelfSelected: shelfSelected,
                  key: UniqueKey())
              : NavigationMap(
                  groundplan: storeGroundPlan,
                  categories: const [categoryModel],
                ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) =>
            setState(() => _currentDestination = value),
        selectedIndex: _currentDestination,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.scatter_plot), label: 'Graph'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
          NavigationDestination(
              icon: Icon(Icons.developer_mode), label: 'Demo'),
        ],
      ),
    );
  }

  void shelfSelected(UiNode node) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Selected node $node')));
    context.read<RoutingCubit>().routeTo(node, categoryModel);
  }
}
