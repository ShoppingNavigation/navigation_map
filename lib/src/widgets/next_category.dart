import 'package:flutter/material.dart';
import 'package:store_navigation_map/src/utils/globals.dart';

class NextCategory extends StatelessWidget {
  const NextCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Aktuelles Produkt'),
                Text('Tiefkühlpizza', style: Globals.textTheme.titleLarge),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Erledigt'),
            )
          ],
        ),
      ),
    );
  }
}
