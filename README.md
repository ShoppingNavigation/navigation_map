Flutter package, that displays a store map and its routing.
Using flutter flame and store_navigation_graph

## Features

- [ ] Show a map of the store
- [ ] "Move" through the store using the typical gestures
- [x] Show debug information about the graph when `kDebugMode`
- [ ] Show route to category / categories
- [ ] Public API to control this package from outside

## Getting started

To use this map you just need to import the package.

## Usage

A working example is in the `example` folder.
You need to initialize a graph (as seen here: [store_navigation_map](https://github.com/ShoppingNavigation/navigation_graph#readme)) and hand it to the `NavigationMap` Widget. Thats all.


```dart
NavigationMap(
    graph: graph,
)
```
