import 'package:flutter/material.dart';
import 'package:lojinha/data/dummy_data.dart';
import 'package:lojinha/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;
  bool _showFavoritesOnly = false;

  List<Product> get items => _showFavoritesOnly
      ? _items.where((product) => product.isFavorite).toList()
      : [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  void showFavoriteOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }
}
