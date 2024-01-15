// cart_provider.dart
import 'package:flutter/material.dart';
import 'product_model.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  double get totalCartPrice => _cartItems.fold(
      0, (total, product) => total + (product.addedToCart ? product.price : 0));

  void addToCart(Product product) {
    if (!_cartItems.contains(product)) {
      _cartItems.add(product);
      product.addedToCart = true;
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    if (_cartItems.contains(product)) {
      _cartItems.remove(product);
      product.addedToCart = false;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.forEach((product) => product.addedToCart = false);
    _cartItems.clear();
    notifyListeners();
  }
}
