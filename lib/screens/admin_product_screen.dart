import 'package:delivery_food/providers/product_provider.dart';
import 'package:delivery_food/screens/mange_products_screen.dart';
import 'package:delivery_food/widgets/admin_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminProductScreen extends StatelessWidget {
  static const routeId = '/admin-products';
  Future _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Your products"),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: ()=>Navigator.of(context).pushNamed(MangeProductsScreen.routeId),)
        ],
      ),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              onRefresh: ()=>_refreshProducts(context),
              child: Consumer<ProductProvider>(
                builder: (context, product, _) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: product.products.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        AdminProductItem(
                          id: product.products[index].id,
                          title: product.products[index].title,
                          img: product.products[index].imgUrl,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}