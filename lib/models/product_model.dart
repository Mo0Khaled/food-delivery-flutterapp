import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProductModel {
  String id;
  String title;
  double price;
  String description;
  double calories;
  String imgUrl;
  String categoryName;
  String restaurantName;

  ProductModel({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.description,
    @required this.calories,
    @required this.imgUrl,
    @required this.categoryName,
    @required this.restaurantName,
  });

  FirebaseAuth auth = FirebaseAuth.instance;

  ProductModel.fromMap(Map snapshot, String id)
      : id = id ?? "",
        title = snapshot['title'] ?? "",
        price = snapshot['price'] ?? "",
        description = snapshot['description'] ?? "",
        calories = snapshot['calories'] ?? "",
        imgUrl = snapshot['imgUrl'] ?? "",
        categoryName = snapshot['categoryName'] ?? "",
        restaurantName = snapshot['restaurantName'] ?? "";

  toJson() {
    return {
      'title': title,
      'price': price,
      'description': description,
      'calories': calories,
      'imgUrl': imgUrl,
      'categoryName': categoryName,
      'restaurantName': restaurantName,
      'creator_id': auth.currentUser.uid,
    };
  }
}
