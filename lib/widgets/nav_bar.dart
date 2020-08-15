import 'package:flutter/material.dart';
import '../screens/product_overview_screen.dart';
import '../screens/orders_screen.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  final double preferredHeight = 75;
  final Widget popUpMenu;

  NavBar({this.popUpMenu});

  @override
  _NavBarState createState() => _NavBarState();

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight);
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return DesktopNavbar(widget.popUpMenu);
        } else {
          return MobileNavbar();
        }
      },
    );
  }
}

class DesktopNavbar extends StatelessWidget {
  final Widget popUpMenu;

  DesktopNavbar(this.popUpMenu);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Dailo MArt",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ProductOverviewScreen.routeName);
                  },
                  child: Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ProductOverviewScreen.routeName);
                  },
                  child: Text(
                    "Shop Now",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(OrdersScreen.routeName);
                  },
                  child: Text(
                    "Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                MaterialButton(
                  color: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  onPressed: () {},
                  child: Text(
                    "Check Out",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                popUpMenu,
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MobileNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: Container(
        child: Column(children: <Widget>[
          Text(
            "Dailo MArt",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Home",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "About Us",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Portfolio",
                style: TextStyle(color: Colors.black),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
