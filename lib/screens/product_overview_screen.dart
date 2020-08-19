import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/nav_bar.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_detail_screen.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import './cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/shop';

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isLoading = true;
  @override
  void initState() {
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadedProduct = _showOnlyFavorites
        ? Provider.of<Products>(context, listen: false).favoriteItems
        : Provider.of<Products>(
            context,
          ).items;
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: NavBar(
        popUpMenu: Row(
          children: [
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text('Only Favourite'),
                    value: FilterOptions.Favorites),
                PopupMenuItem(
                    child: Text('All Products'), value: FilterOptions.All),
              ],
            ),
            Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
              value: cart.itemCount.toString(),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // Center(
                //   child: Text(
                //     'We will expand along with your desire .  \n just give us an opportunity to serve you.',
                //   ),
                // ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: loadedProduct.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      // crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      value: loadedProduct[i],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ProductDetailScreen.routeName,
                                arguments: loadedProduct[i].id,
                              );
                            },
                            child: Image.network(
                              loadedProduct[i].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          footer: GridTileBar(
                            backgroundColor: Colors.black87,
                            leading: Consumer<Products>(
                              builder: (ctx, product, child) => IconButton(
                                icon: Icon(loadedProduct[i].isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                                color: Theme.of(context).accentColor,
                                onPressed: () {
                                  setState(() {
                                    loadedProduct[i].toggleFavoriteStatus();
                                  });
                                },
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.shopping_cart),
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                setState(() {
                                  cart.addItem(
                                    loadedProduct[i].id,
                                    loadedProduct[i].price,
                                    loadedProduct[i].title,
                                  );
                                });
                                Scaffold.of(ctx).hideCurrentSnackBar();
                                Scaffold.of(ctx).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Items Added to cart',
                                    ),
                                    duration: Duration(seconds: 2),
                                    action: SnackBarAction(
                                        label: 'UNDO',
                                        onPressed: () {
                                          setState(() {
                                            cart.removeSingleItem(
                                                loadedProduct[i].id);
                                          });
                                        }),
                                  ),
                                );
                              },
                            ),
                            title: Text(
                              loadedProduct[i].title,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
