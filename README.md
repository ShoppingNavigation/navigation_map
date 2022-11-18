Flutter package, that displays a store map and its routing.
Using flutter flame and store_navigation_graph

## Features

- [ ] Show a map of the store
- [x] "Move" through the store using the typical gestures
- [ ] Improve scaling with gesture input
- [x] Show debug information about the graph when `kDebugMode`
- [ ] Show route to category / categories
- [ ] Public API to control this package from outside

## Getting started

To use this map you just need to import the package.

## Usage

A working example is in the `example` folder.
You need to initialize a graph (as seen here: [store_navigation_map](https://github.com/ShoppingNavigation/navigation_graph#readme)) and hand it to the `NavigationMap` Widget. The only change you have to do is use `UiNode` instead of `Node`. The `UiNode` also has a field for the position of the node.


```dart
NavigationMap(
    graph: graph,
)
```

## About the structure

The whole thing is wrapped in a `Game` widget from flame with the exception of `MapControls` and `NextCategory`.
The game contains a world, which by it self only contains a `MapContainer`. The `MapContainer` is a positioned Component of which the position is changed on every drag update.

### Debug view
Everything debug related should be put in the `/debug` folder. To show the whole graph for debugging purposes, you just need to add `DebugGraph` Component to the `MapContainer`.
