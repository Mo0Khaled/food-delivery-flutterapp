
import 'package:flutter/material.dart';
class ProductDetails extends StatelessWidget {
  static const routeId = '/product-details';
  final String id;
  final String title;
  final String imgUrl;
  final String description;
  final double calories;

  ProductDetails({
    @required this.id,
    @required this.title,
    @required this.imgUrl,
    @required this.description,
    @required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    Border borderButton = Border(
      top: BorderSide(width: 1, color: Colors.grey.shade400),
      right: BorderSide(width: 1, color: Colors.grey.shade400),
      left: BorderSide(width: 1, color: Colors.grey.shade400),
      bottom: BorderSide(width: 1, color: Colors.grey.shade400),
    );
    return Container(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Hero(
                    tag: id,
                    child: Image.network(
                      imgUrl,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.25,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                    ),
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
                      title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .8,
                      ),
                    ),
                    Text(
                      "$calories Cal.",
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
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .5,
                    height: 1.3,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                child: Row(
                  children: [
                    buildIconButton(context: context,border: borderButton,icon: Icons.remove,onTap: (){}),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "1",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    buildIconButton(context: context,border: borderButton,icon: Icons.add,onTap: (){}),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildIconButton({BuildContext context, Border border,Function onTap,IconData icon}) {
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
