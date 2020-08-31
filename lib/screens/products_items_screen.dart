import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_food/models/product_model.dart';
import 'package:delivery_food/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/productCard.dart';
import 'package:provider/provider.dart';
import '../providers/authinticate_provider.dart';

class ProductsItemsScreen extends StatelessWidget {
  static const routeId = 'products';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> products;
    return Scaffold(
      appBar: AppBar(
        title: FlatButton(
          child: Text("sign out"),
          onPressed: () {
            Provider.of<Autheticate>(context, listen: false).signout(context);
          },
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: productProvider.fetchProductsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data.docs
                  .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
                  .toList();
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    ProductCard(productDetails: products[index]),
              );
            } else {
              return Text("Error");
            }
          },
        ),
      ),
    );
  }
}
