import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/products.dart';
import 'package:store_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context); //247
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                      content: Text(
                    'Deleting Failed',
                    textAlign: TextAlign.center,
                  )));
                }
              },
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
