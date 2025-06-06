
class BagManager {
  static final BagManager _instance = BagManager._internal();
  factory BagManager() => _instance;

  BagManager._internal();

  List<Map<String, dynamic>> bagItems = [];

  void addItem(Map<String, dynamic> item) {
    bagItems.add(item);
  }

  void removeItem(int index) {
    if (index >= 0 && index < bagItems.length) {
      bagItems.removeAt(index);
    }
  }
}