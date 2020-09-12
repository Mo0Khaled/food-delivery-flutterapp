import 'package:delivery_food/providers/cart_provider.dart';
import 'package:delivery_food/providers/order_provider.dart';
import 'package:delivery_food/screens/google_maps_screen.dart';
import 'package:delivery_food/widgets/cart/cart_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: cartProvider.itemCount == 0
          ? Center(
              child: Text("No Items"),
            )
          : SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cart",
                            style: TextStyle(
                              fontSize: 35,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              size: 35,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              cartProvider.clearCart();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          itemCount: cartProvider.cartProducts.length,
                          itemBuilder: (context, index) => CartItemWidget(
                            id: cartProvider.cartProducts.values
                                .toList()[index]
                                .id,
                            title: cartProvider.cartProducts.values
                                .toList()[index]
                                .title,
                            quantity: cartProvider.cartProducts.values
                                .toList()[index]
                                .quantity,
                            price: cartProvider.cartProducts.values
                                .toList()[index]
                                .price,
                            img: cartProvider.cartProducts.values
                                .toList()[index]
                                .img,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total:",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "\$${cartProvider.totalAmount}",
                              style: TextStyle(
                                color: Color(0xFFFFB41E),
                                fontWeight: FontWeight.w700,
                                fontSize: 27,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 30),
                        child: InkWell(
                          onTap: () async {
                            await orderProvider.addOrder(
                                cartProvider.cartProducts.values.toList(),
                                cartProvider.totalAmount);
                            cartProvider.clearCart();
                            Navigator.of(context).pushReplacementNamed(
                                GoogleMapsScreen.nameRoute);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFB41E),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
    );
  }
}
