import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_food/models/product_model.dart';
import 'package:delivery_food/providers/product_provider.dart';
import 'file:///F:/work/fluter/delivery_food/lib/widgets/product/productCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsItemsScreen extends StatelessWidget {
  static const routeId = 'products';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> products;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder(
          stream: productProvider.fetchProductsAsStream(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              products = snapshot.data.docs.map((doc) => ProductModel.fromMap(doc.data(), doc.id)).toList();
              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context,index) => ProductCard(productDetails: products[index]),
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }
}

