import 'package:example/destination_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

import 'only_graph.dart';
import 'groundplan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBFF5A3))),
      home: BlocProvider(
        create: (context) => RoutingCubit(),
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
  int _currentDestination = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routingCubit = context.read<RoutingCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Map Example'), actions: [
        IconButton(
            onPressed: () =>
                context.read<RoutingCubit>().routeTo(startNode, getranke),
          icon: const Icon(Icons.route),
        ),
        IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => DestinationSelector(routingCubit: routingCubit),
          ),
          icon: const Icon(Icons.alt_route),
        )
      ]),
      body: _currentDestination == 0
          ? NavigationMap(groundplan: groundPlanOnlyGraph, key: UniqueKey())
          : NavigationMap(
              groundplan: groundPlan,
              canShowDebug: true,
              adminActive: true,
              onShelfSelected: shelfSelected,
              key: UniqueKey()),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => setState(() => _currentDestination = value),
        selectedIndex: _currentDestination,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.scatter_plot), label: 'Graph'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
        ],
      ),
    );
  }

  void shelfSelected(UiNode node) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected node $node')));
  }
}
