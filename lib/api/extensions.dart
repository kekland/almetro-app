extension IndexedMap<T> on List<T> {
  List<K> indexMap<K>(K Function(T, int) mapFunction) {
    final newArray = <K>[];

    for (var i = 0; i < this.length; i++) {
      final elem = this[i];
      newArray.add(mapFunction(elem, i));
    }

    return newArray;
  }
}
