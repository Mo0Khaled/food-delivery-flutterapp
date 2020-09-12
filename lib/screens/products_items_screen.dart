import 'package:delivery_food/productCard.dart';
import 'package:delivery_food/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../widgets/productCard.dart';
// import 'package:provider/provider.dart';
// import '../providers/authinticate_provider.dart';

class ProductsItemsScreen extends StatelessWidget {
  static const routeId = 'products';

  Future<void> refresh(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final filterProducts = Provider.of<ProductProvider>(context, listen: false)
        .filterByRestaurant(productId);
    return Scaffold(
      body: FutureBuilder(
        future: refresh(context),
        builder: (context, snapshot) => ListView.builder(
          itemCount: filterProducts.length,
          itemBuilder: (context, index) =>
              ProductCardItem(productDetails: filterProducts[index]),
        ),
      ),
    );
  }
}

// StreamBuilder(
// stream: productProvider.fetchProductsAsStream(),
// builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
// if(snapshot.hasData){
// products = snapshot.data.docs.map((doc) => ProductModel.fromMap(doc.data(), doc.id)).toList();
// products.contains(productId);
// return ListView.builder(
// itemCount: products.length,
// itemBuilder: (context,index) => ProductCard(productDetails: products[index]),
// );
// }else{
// return Center(child: CircularProgressIndicator(),);
// }
// },
// ),
