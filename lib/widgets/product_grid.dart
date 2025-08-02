import 'package:flutter/material.dart';
import 'package:lojinha/models/product.dart';
import 'package:lojinha/models/product_list.dart';
import 'package:lojinha/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatefulWidget {
  final bool showFavoritesOnly;

  ProductGrid({
    super.key,
    required this.showFavoritesOnly,
  });

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(
      context,
    );

    final List<Product> loadedProducts =
        widget.showFavoritesOnly ? provider.favoriteItems : provider.items;

    return loadedProducts.isEmpty
        ? Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.showFavoritesOnly
                      ? Icons.favorite_border
                      : Icons.inventory_2_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.showFavoritesOnly
                      ? "Nenhum favorito ainda"
                      : "Nenhum produto encontrado",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.showFavoritesOnly
                      ? "Marque produtos como favoritos para vê-los aqui"
                      : "Tente ajustar os filtros de busca",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: loadedProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.62,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: loadedProducts[index],
                  child: ProductItem(),
                ));
  }
}
