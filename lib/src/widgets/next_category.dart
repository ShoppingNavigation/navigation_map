import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_navigation_map/src/utils/globals.dart';
import 'package:store_navigation_map/store_navigation_map.dart';

class NextCategory extends StatelessWidget {
  const NextCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutingCubit, RoutingState>(
      builder: (context, state) {
        if (state is RoutingSingleRoute) {
          return _singleRoute(context, state);
        }

        if (state is RoutingMultiRoute) {
          return _multiRoute(context, state);
        }

        return Container();
      },
    );
  }

  Widget _singleRoute(BuildContext context, RoutingSingleRoute state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Aktuelle Kategorie'),
                Text(state.currentCategory.name, style: Globals.textTheme.titleLarge),
              ],
            ),
            TextButton(
              onPressed: () {
                context.read<RoutingCubit>().finish();
              },
              child: const Text('Erledigt'),
            )
          ],
        ),
      ),
    );
  }

  Widget _multiRoute(BuildContext context, RoutingMultiRoute state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Aktuelle Kategorie (${state.currentSubRoute} von ${state.destinationCount})'),
                Text(state.currentCategory.name, style: Globals.textTheme.titleLarge),
              ],
            ),
            TextButton(
              onPressed: () {
                context.read<RoutingCubit>().finish();
              },
              child: const Text('Erledigt'),
            )
          ],
        ),
      ),
    );
  }
}
