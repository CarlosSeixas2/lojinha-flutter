import 'package:flutter/material.dart';
import 'package:lojinha/models/cart.dart';
import 'package:lojinha/utils/app_routes.dart';
import 'package:lojinha/widgets/my_badge.dart';
import 'package:lojinha/widgets/product_grid.dart';
import 'package:provider/provider.dart';

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            floating: true,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Lojinha",
                style: TextStyle(
                  color: Color(0xFF1C1B1F),
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF6750A4),
                      Color(0xFF8B5CF6),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              // Botão de filtro de favoritos
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        _showFavorites = !_showFavorites;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _showFavorites
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 18,
                            color: _showFavorites
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Favoritos",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _showFavorites
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Consumer<Cart>(
                builder: (context, cart, child) => Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: MyBadge(
                    value: cart.itemCount.toString(),
                    color: Colors.red,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.cart);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Conteúdo principal
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _showFavorites ? "Seus Favoritos" : "Descubra Produtos",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C1B1F),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _showFavorites
                            ? "Produtos que você marcou como favoritos"
                            : "Encontre os melhores produtos para você",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  // Grid de produtos
                  ProductGrid(
                    showFavoritesOnly: _showFavorites,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
