import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lojinha/models/product_list.dart';
import 'package:lojinha/pages/product_detail_page.dart';
import 'package:lojinha/pages/products_overview_page.dart';
import 'package:lojinha/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lojinha',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            secondary: Colors.redAccent,
          ),
        ),
        home: ProductsOverviewPage(),
        routes: {AppRoutes.productDetail: (context) => ProductDetailPage()},
      ),
    );
  }
}
