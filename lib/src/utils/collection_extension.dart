extension CollectionExtension<E> on Iterable<E> {
  E minBy<T extends Comparable<Object>>(T Function(E) selector) {
    int minIndex = 0;
    T? currentMin;

    for (int i = 0; i < length; i++) {
      final currentElement = selector(elementAt(i));
      if (currentMin == null || currentElement.compareTo(currentMin) == -1) {
        minIndex = i;
        currentMin = currentElement;
      }
    }

    return elementAt(minIndex);
  }

  E maxBy<T extends Comparable<Object>>(T Function(E) selector) {
    int maxIndex = 0;
    T? currentMax;

    for (int i = 0; i < length; i++) {
      final currentElement = selector(elementAt(i));
      if (currentMax == null || currentElement.compareTo(currentMax) == 1) {
        maxIndex = i;
        currentMax = currentElement;
      }
    }

    return elementAt(maxIndex);
  }
}
