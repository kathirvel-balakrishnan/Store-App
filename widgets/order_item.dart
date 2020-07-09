import 'package:flutter/material.dart';
import 'package:store_app/providers/orders.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height:
          _expanded ? min(widget.order.products.length * 20.0 + 120, 270) : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$ ${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(DateFormat('dd-MM-yyyy \t  hh:mm:ss')
                  .format(widget.order.dateTime)),
              trailing: IconButton(
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  }),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded
                  ? min(widget.order.products.length * 20.0 + 20, 100)
                  : 0,
              child: ListView(
                  children: widget.order.products
                      .map((prod) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  prod.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${prod.quantity} x \$${prod.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList()),
            )
          ],
        ),
      ),
    );
  }
}
