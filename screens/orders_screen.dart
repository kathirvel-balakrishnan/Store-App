import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/orders.dart' show Orders;
import 'package:store_app/widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                  ),
                );
              } else {
                if (dataSnapshot.error != null) {
                  //error handling
                  return Center(
                    child: Text("An error occured"),
                  );
                } else {
                  return Consumer<Orders>(
                      builder: (ctx, orderData, child) => ListView.builder(
                            itemBuilder: (context, index) =>
                                OrderItem(orderData.orders[index]),
                            itemCount: orderData.orders.length,
                          ));
                }
              }
            }));
  }
}
