import 'package:delivery_food/models/product_model.dart';
import 'package:delivery_food/widgets/product/product_details.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productDetails;

  ProductCard({@required this.productDetails});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: .8,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        width: double.infinity,
        // height: MediaQuery.of(context).size.height * 0.26,
        child: InkWell(
          onTap: () {
            // Navigator.of(context).pushNamed(ProductDetails.routeId,arguments: productDetails.id);
            showModalBottomSheet(
              context: context,
              builder: (context) => ProductDetails(
                title: productDetails.title,
                imgUrl: productDetails.imgUrl,
                calories: productDetails.calories,
                description: productDetails.description,
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 2,
            child: Column(
              children: [
                Image.network(
                  productDetails.imgUrl,
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productDetails.title,
                        style: titleStyle,
                      ),
                      Text(
                        "\$${productDetails.price}",
                        style: titleStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
