import 'package:delivery_food/models/product_model.dart';

class RestaurantModel {
  final String id;
  final String category;
  final double rank;
  final String imgUrl;
  final String deliveryTime;
  final String desiredOrders;

  RestaurantModel(
      {this.id,
      this.category,
      this.deliveryTime,
      this.desiredOrders,
      this.imgUrl,
      this.rank});
}
