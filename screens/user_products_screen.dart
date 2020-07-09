import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/products.dart';
import 'package:store_app/screens/edit_product_screen.dart';
import 'package:store_app/widgets/app_drawer.dart';
import 'package:store_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context,listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //266
    //final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      _refreshProducts(context);
                    },
                    //266
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: productsData.items.length,
                          itemBuilder: (_, index) => Column(
                            children: <Widget>[
                              UserProductItem(
                                  id: productsData.items[index].id,
                                  title: productsData.items[index].title,
                                  imageUrl: productsData.items[index].imageUrl),
                              Divider()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
      drawer: AppDrawer(),
    );
  }
}
