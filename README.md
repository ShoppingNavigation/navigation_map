Flutter package, that displays a store map and its routing.
Using flutter flame and store_navigation_graph

## Features

- [x] Show a map of the store
- [x] "Move" through the store using the typical gestures
- [ ] Improve scaling with gesture input
- [x] Show debug information about the graph when `kDebugMode`
- [x] Show route to category / categories
- [x] Public API to control this package from outside
- [x] Connect shelves with catgories

## Getting started

To use this map you just need to import the package.

## Usage

A working example is in the `example` folder.
There is just one mandatory field for the navigation map, which is the `groundplan`. The groundplan is an object which contains all information like the outline of the store, the shelfs and the navigation graph, which you need to initialize as seen here: [store_navigation_map](https://github.com/ShoppingNavigation/navigation_graph#readme). The only change you have to do is use `UiNode` instead of `Node`. The `UiNode` also has a field for the position of the node.

```dart
NavigationMap(
    groundplan: groundplan,
)
```

Added to that, you need to add the `RoutingCubit` to a top level bloc-provider. With that cubit you can control the routes.

## About the structure

The whole thing is wrapped in a `Game` widget from flame with the exception of `MapControls` and `NextCategory`.
The game contains a world, which by it self only contains a `MapContainer`. The `MapContainer` is a positioned Component of which the position is changed on every drag update.

### Debug view
Everything debug related should be put in the `/debug` folder. To show the whole graph for debugging purposes, you just need to add `DebugGraph` Component to the `MapContainer`.
