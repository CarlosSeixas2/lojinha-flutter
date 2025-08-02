import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lojinha/models/cart_item.dart';
import 'package:lojinha/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;

    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });

    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (value) => CartItem(
                id: value.id,
                productId: value.productId,
                name: value.name,
                quantity: value.quantity + 1,
                price: value.price,
                imageUrl: value.imageUrl,
              ));
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.title,
          quantity: 1,
          price: product.price,
          imageUrl: product.imageUrl,
        ),
      );
    }

    notifyListeners();
  }

  CartItem? findCartItemById(String id) {
    if (_items.containsKey(id)) {
      return _items[id];
    } else {
      return null;
    }
  }

  void deleteItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeItem(String productId) {
    CartItem? cartItem = findCartItemById(productId);

    if (cartItem != null) {
      cartItem.quantity > 1
          ? _items.update(
              productId,
              (existingItem) => CartItem(
                id: existingItem.id,
                productId: existingItem.productId,
                name: existingItem.name,
                quantity: existingItem.quantity - 1,
                price: existingItem.price,
                imageUrl: existingItem.imageUrl,
              ),
            )
          : _items.remove(productId);
    }

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
