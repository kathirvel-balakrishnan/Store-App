import 'package:flutter/material.dart';
import 'package:store_app/helpers/custom_route.dart';
import 'package:store_app/providers/auth.dart';
import 'package:store_app/providers/cart.dart';
import 'package:store_app/screens/auth_screen.dart';
import 'package:store_app/screens/cart_screen.dart';
import 'package:store_app/providers/orders.dart';
import 'package:store_app/screens/edit_product_screen.dart';
import 'package:store_app/screens/orders_screen.dart';
import 'package:store_app/screens/user_products_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // also cleans old data
    //this constructor is used where the widget is newly built always
    //whereas .value constructor is used in places where widget is present
    //in a list or grid where after deleting it takes the old widget's position
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (context, auth, previousOrders) => Orders(auth.token,
              auth.userId, previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'Shopie',
                theme: ThemeData(
                    primarySwatch: Colors.yellow,
                    accentColor: Colors.orange,
                    fontFamily: 'Lato',
                    pageTransitionsTheme: PageTransitionsTheme(builders: {
                      TargetPlatform.android: CustomePageTransitionBuilder(),
                    })),
                home: auth.isAuth
                    ? ProductsOverviewScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) =>
                            authResultSnapshot == ConnectionState.waiting
                                ? Center(
                                    child: Text('Loading...'),
                                  )
                                : AuthScreen()),
                routes: {
                  OrdersScreen.routeName: (context) => OrdersScreen(),
                  CartScreen.routeName: (context) => CartScreen(),
                  ProductDetailScreen.routeName: (context) =>
                      ProductDetailScreen(),
                  UserProductsScreen.routeName: (context) =>
                      UserProductsScreen(),
                  EditProductScreen.routeName: (context) => EditProductScreen(),
                },
                debugShowCheckedModeBanner: false,
              )),
    );
  }
}
