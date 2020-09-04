import 'package:delivery_food/constants.dart';
import 'package:delivery_food/models/restaurant_model.dart';
import 'package:delivery_food/screens/admin_restaurant_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantProvider with ChangeNotifier {
  FirebaseFirestore _store = FirebaseFirestore.instance;
  List<RestaurantModel> _restaurants = [];

  List<RestaurantModel> get restaurantsList {
    return _restaurants;
  }

  List<RestaurantModel> filterByCategory(String name) {
    return _restaurants
        .where((element) => element.category.contains(name))
        .toList();
  }

  void addRestaurant(RestaurantModel restaurant, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await _store.collection(kRestaurantsCollection).add(
      {
        'restaurant_name': restaurant.restaurant,
        kRestaurantCategory: restaurant.category,
        kRestaurantDeliveryTime: restaurant.deliveryTime,
        kRestaurantImgUrl: restaurant.imgUrl,
        kRestaurantDesiredOrders: restaurant.desiredOrders,
        kRestaurantRank: restaurant.rank,
        'creator_id': null,
      },
    );

    Navigator.of(context).pushNamed(AdminRestaurantScreen.nameRoute);
  }

  Stream fetchDataFromDB() {
    return _store.collection(kRestaurantsCollection).snapshots();
  }

  Future<List<RestaurantModel>> fetch() async {
    List<RestaurantModel> res = [];
    var snapshot = await _store.collection(kRestaurantsCollection).get();
    for (var doc in snapshot.docs) {
      var data = doc.data();
      res.add(
        RestaurantModel(
          restaurant: data['restaurant_name'],
          deliveryTime: data[kRestaurantDeliveryTime],
          imgUrl: data[kRestaurantImgUrl],
          desiredOrders: data[kRestaurantDesiredOrders],
          category: data[kRestaurantCategory],
          rank: data[kRestaurantRank],
          id: doc.id,
        ),
      );
    }
    _restaurants = res;
    return _restaurants;
  }

  deleteRestaurant(String id) async {
    await _store.collection(kRestaurantsCollection).doc(id).delete();
    _restaurants.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  updateRestaurants(String id, RestaurantModel rest) async {
    await _store.collection(kRestaurantsCollection).doc(id).update({
      kRestaurantImgUrl: rest.imgUrl,
      kRestaurantCategory: rest.category,
      kRestaurantDesiredOrders: rest.desiredOrders,
      kRestaurantRank: rest.rank,
      kRestaurantDeliveryTime: rest.deliveryTime
    });
    notifyListeners();
  }

  findById(String id) {
    RestaurantModel rest =
        _restaurants.firstWhere((element) => element.id == id);
    return rest;
  }
}
