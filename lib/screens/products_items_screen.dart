import 'package:delivery_food/providers/product_provider.dart';
import 'file:///F:/work/fluter/delivery_food/lib/productCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../widgets/productCard.dart';
// import 'package:provider/provider.dart';
// import '../providers/authinticate_provider.dart';

class ProductsItemsScreen extends StatelessWidget {
  static const routeId = 'products';

  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context).settings.arguments as String;
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: FutureBuilder(
        future: productProvider.fetchProducts(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: productProvider.products.length,
                    itemBuilder: (context, index) => ProductCardItem(
                        productDetails: productProvider.products[index]),
                  ),
      ),
    );
  }
}
//
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
