import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String img;

  CartItemWidget({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          // height: 70,
          decoration: BoxDecoration(
            color: Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(11),
          ),
          child: ListTile(
            leading: Image.network(
              img,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            title: Text(title,style: TextStyle(
              fontSize: 20,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w600,
            ),),
            subtitle: Text("x$quantity",style: TextStyle(fontSize: 16),),
            trailing: Text(
              '\$$price',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
