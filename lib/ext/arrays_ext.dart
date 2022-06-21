extension ListExt<T> on List<T> {
  void addAllCheckClear(bool isClear, List<T>? it) {
    if (isClear) {
      clear();
    }
    if (it != null) {
      addAll(it);
    }
  }
}
