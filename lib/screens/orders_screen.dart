import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../widgets/nav_bar.dart';

import '../providers/orders.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context).orders;
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: NavBar(
        popUpMenu: Row(
          children: [
            Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              value: cart.itemCount.toString(),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: ordersData.length,
        itemBuilder: (ctx, i) => Card(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                title: Text('NPR ${ordersData[i].amount}'),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(ordersData[i].dateTime),
                ),
                trailing: IconButton(
                    icon:
                        Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    }),
              ),
              _expanded
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      height:
                          min(ordersData[i].products.length * 20.0 + 10, 100),
                      child: ListView(
                        children: ordersData[i]
                            .products
                            .map(
                              (prod) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    prod.title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${prod.quantity} x NPR${prod.price}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
