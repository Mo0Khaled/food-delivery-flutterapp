import 'package:delivery_food/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeId = '/product-details';
  final String id;
  final String title;
  final String imgUrl;
  final String description;
  final double calories;
  final double price;

  ProductDetails({
    @required this.id,
    @required this.title,
    @required this.imgUrl,
    @required this.description,
    @required this.calories,
    @required this.price,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _visible = true;
      });
    });
  }
  int quantity = 1;


  @override
  Widget build(BuildContext context) {
    Border borderButton = Border(
      top: BorderSide(width: 1, color: Colors.grey.shade400),
      right: BorderSide(width: 1, color: Colors.grey.shade400),
      left: BorderSide(width: 1, color: Colors.grey.shade400),
      bottom: BorderSide(width: 1, color: Colors.grey.shade400),
    );
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: _visible ? 1 : 0,
      child: Container(
        height: 500,
        color: Color(0xFF757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 500),
                  padding: _visible
                      ? EdgeInsets.symmetric(vertical: 5)
                      : EdgeInsets.symmetric(vertical: 0),
                  child: Image.network(
                    widget.imgUrl,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.25,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .8,
                      ),
                    ),
                    Text(
                      "${widget.calories} Cal.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .5,
                    height: 1.3,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                child: Row(
                  children: [
                    buildIconButton(
                      context: context,
                      border: borderButton,
                      icon: Icons.remove,
                      onTap: () {
                        setState(() {
                          if(quantity > 1)
                            quantity--;
                        });
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                     "$quantity",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    buildIconButton(
                      context: context,
                      border: borderButton,
                      icon: Icons.add,
                      onTap: () {
                        setState(() {
                          quantity++;

                        });
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          cartProvider.addProductToCart(
                            widget.id,
                            widget.title,
                            widget.price,
                            widget.imgUrl,
                            quantity,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.06,
                          color: Color(0xFFFFB41E),
                          child: Text(
                            "Add To Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: .5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildIconButton(
      {BuildContext context, Border border, Function onTap, IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: border,
        ),
        child: Icon(icon),
      ),
    );
  }
}
