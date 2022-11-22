import 'package:example/groundplan.dart';
import 'package:flutter/material.dart';
import 'package:store_navigation_map/store_navigation_map.dart';
import 'package:store_shared_models/store_shared_models.dart';

class DestinationSelector extends StatefulWidget {
  final RoutingCubit routingCubit;
  const DestinationSelector({super.key, required this.routingCubit});

  @override
  State<DestinationSelector> createState() => _DestinationSelectorState();
}

class _DestinationSelectorState extends State<DestinationSelector> {
  final List<CategoryModel> _categories = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
            onPressed: () {
              widget.routingCubit.routeToAll(startNode, _categories);
              Navigator.of(context).pop();
            },
            child: const Text('Start'))
      ],
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
            shrinkWrap: true,
            children: List.generate(categories.length, (index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () => _selectCategory(category),
                child: ListTile(
                  title: Text(
                    category.name,
                  ),
                  trailing: Checkbox(
                    value: _categories.contains(category),
                    onChanged: (value) => _selectCategory(category),
                  ),
                ),
              );
            })),
      ),
    );
  }

  void _selectCategory(CategoryModel category) {
    setState(() {
      if (_categories.contains(category)) {
        _categories.remove(category);
        return;
      }
      _categories.add(category);
    });
  }
}
