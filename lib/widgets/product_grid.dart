import 'package:flutter/material.dart';
import 'package:lojinha/models/product.dart';
import 'package:lojinha/models/product_list.dart';
import 'package:lojinha/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;

    return loadedProducts.isEmpty
        ? Center(
            child: Text("Nenhum produto encontrado!"),
          )
        : GridView.builder(
            itemCount: loadedProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //exibe 2 produtos por linha
              childAspectRatio: 3 / 2, //proporção de altura e largura
              crossAxisSpacing: 10, //espaçamento horizontal entre os produtos
              mainAxisSpacing: 10, //espaçamento vertical entre os produtos
            ),
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: loadedProducts[index],
                  child: ProductItem(),
                ));
  }
}
