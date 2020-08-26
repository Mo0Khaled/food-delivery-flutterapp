import 'package:flutter/material.dart';

void main() {
  runApp(FoodDelivery());
}

class FoodDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Food',
      theme: ThemeData(),
      home: Scaffold(),
    );
  }
}

