import 'package:flutter/foundation.dart';

class QuantityProvider extends ChangeNotifier {
  final Map<String, int> _quantities = {};

  int getQuantity(String productId) => _quantities[productId] ?? 0;

  void add(String productId) {
    _quantities[productId] = 1;
    notifyListeners();
  }

  void increment(String productId) {
    _quantities[productId] = (_quantities[productId] ?? 0) + 1;
    notifyListeners();
  }

  void decrement(String productId) {
    if ((_quantities[productId] ?? 0) > 1) {
      _quantities[productId] = _quantities[productId]! - 1;
    } else {
      _quantities.remove(productId);
    }
    notifyListeners();
  }

  int get totalCartCount {
    return _quantities.values.fold<int>(0, (sum, qty) => sum + qty);
  }

  // ✅ Add this getter
  Map<String, int> get quantities => _quantities;
}
