import 'package:delivery_food/models/cart_model.dart';

class OrderItemModel {
  final String id;
  final double amount;
  final List<CartItemModel> productsToOrder;
  final DateTime dateTime;

  OrderItemModel({
    this.id,
    this.amount,
    this.productsToOrder,
    this.dateTime,
  });
}
