import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_food/models/product_model.dart';
import 'package:delivery_food/providers/product_provider.dart';
import 'package:delivery_food/widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
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
              return Text("Error");
            }
          },
        ),
      ),
    );
  }
}

