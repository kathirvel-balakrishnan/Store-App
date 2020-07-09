import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  
  final bool showFavourites;

  ProductsGrid(this.showFavourites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavourites?productsData.favouriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        //ChangeNotifierProvider.value() constructor is used coz new product show up in grid,and default construct causes bug
        value: products[index],
        child: ProductItem(),
      ),
    );
  }
}
