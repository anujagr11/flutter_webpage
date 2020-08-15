import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      body: Card(
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Chip(
                label: Text(
                  'NPR.${cart.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              FlatButton(
                onPressed: () {
                  Provider.of<Orders>(context, listen: false).addOrder(
                    cart.items.values.toList(),
                    cart.totalAmount,
                  );
                  cart.clear();
                },
                child: Text('ORDER NOW'),
                textColor: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) => Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 4,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                cart.removeItem(
                                    cart.items.values.toList()[i].id);
                              });
                            }),
                        title: Text(cart.items.values.toList()[i].title),
                        subtitle: Text(
                          'Total: ${cart.items.values.toList()[i].quantity * cart.items.values.toList()[i].price}',
                        ),
                        trailing:
                            Text('${cart.items.values.toList()[i].quantity} x'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
