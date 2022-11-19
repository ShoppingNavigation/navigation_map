import 'package:flutter/material.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

import 'only_graph.dart';
import 'groundplan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  

  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBFF5A3))),
      home: const Example(),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Map Example')),
      body: _currentDestination == 0
          ? NavigationMap(groundplan: groundPlanOnlyGraph, key: UniqueKey())
          : NavigationMap(groundplan: groundPlan, key: UniqueKey()),
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
}
