import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/nav_bar.dart';
import '../providers/products.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'NPR ${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
