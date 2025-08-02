import 'package:flutter/material.dart';
import 'package:lojinha/data/dummy_data.dart';
import 'package:lojinha/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((product) => product.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void toggleFavoriteStatus(Product product) {
    product.toggleFavoriteStatus();
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
