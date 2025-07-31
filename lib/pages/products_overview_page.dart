import 'package:flutter/material.dart';
import 'package:lojinha/models/product_list.dart';
import 'package:lojinha/widgets/product_grid.dart';
import 'package:provider/provider.dart';

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Minha Loja",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Favoritos"),
                value: "favoritos",
              ),
              PopupMenuItem(
                child: Text("Todos"),
                value: "todos",
              ),
            ],
            onSelected: (value) {
              if (value == "favoritos") {
                provider.showFavoriteOnly();
              } else if (value == "todos") {
                provider.showAll();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductGrid(),
      ),
    );
  }
}
