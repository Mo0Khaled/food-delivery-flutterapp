class RestaurantModel {
  final String id;
  final String restaurant;
  final String category;
  final double rank;
  final String imgUrl;
  final String deliveryTime;
  final String desiredOrders;

  RestaurantModel({
    this.id,
    this.restaurant,
    this.category,
    this.deliveryTime,
    this.desiredOrders,
    this.imgUrl,
    this.rank,
  });
}
