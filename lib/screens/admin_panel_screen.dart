import 'package:delivery_food/screens/admin_product_screen.dart';
import 'package:delivery_food/screens/admin_restaurant_screen.dart';

import 'package:flutter/material.dart';

class AdminPanelScreen extends StatelessWidget {
  static const String nameRoute = "/admin-panel";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin panel",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            adminContainer(
                () =>
                    Navigator.of(context).pushNamed(AdminProductScreen.routeId),
                "show your products"),
            adminContainer(
                () => Navigator.of(context)
                    .pushNamed(AdminRestaurantScreen.nameRoute),
                "show your restaurants")
          ],
        ),
      ),
    );
  }
}

Widget adminContainer(Function route, String title) {
  return GestureDetector(
    onTap: () {},
    child: Card(
        margin: const EdgeInsets.all(10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: ListTile(
          title: Text(title),
          onTap: route,
        )),
  );
}
