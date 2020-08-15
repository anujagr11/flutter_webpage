import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './edit_product_screen.dart';

class AdminScreen extends StatelessWidget {
  static const routeName = '/admin';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: productsData.length,
          itemBuilder: (ctx, i) => Column(
            children: [
              ListTile(
                title: Text(
                  productsData[i].title,
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    productsData[i].imageUrl,
                  ),
                ),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              EditProductScreen.routeName,
                              arguments: productsData[i].id);
                        },
                        color: Theme.of(context).primaryColor,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<Products>(context, listen: false)
                              .deleteProduct(productsData[i].id);
                        },
                        color: Theme.of(context).errorColor,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
