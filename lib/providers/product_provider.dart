import 'package:delivery_food/models/product_model.dart';
import 'package:delivery_food/network/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../locator.dart';

class ProductProvider with ChangeNotifier {
  Api _api = locator<Api>();
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  List<String> _category = [];

  List<String> get category => _category;

  List<String> _restaurant = [];

  List<String> get restaurant => _restaurant;

  ProductModel findById(String id) =>
      _products.firstWhere((prod) => prod.id == id);

  List<ProductModel> filterByRestaurant(String name) {
    return _products.where((cat) => cat.restaurantName.contains(name)).toList();
  }

  Future<List<ProductModel>> fetchProducts() async {
    var response = await _api.getDataCollection();
    _products = response.docs
        .map((doc) {
        return ProductModel.fromMap(doc.data(), doc.id);

    })
        .toList();
    notifyListeners();
    return _products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<ProductModel> getProductById(String id) async {
    var doc = await _api.getDocById(id);
    return ProductModel.fromMap(doc.data(), doc.id);
  }

  Future addProduct(ProductModel productModel) async {
    try {
      await _api.addDoc(productModel.toJson());
      // notifyListeners();
      return;
    } catch (error) {
      throw error;
    }
  }

  Future updateProduct(ProductModel newProd, String id) async {
    await _api.updateDoc(newProd.toJson(), id);
  }

  Future deleteProduct(String id) async {
    await _api.removeDoc(id);
    // notifyListeners();
    return;
  }

  Future fetchCategories() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    List<String> result = [];
    await firestore.collection('restaurants').get().then((data) {
      for (var doc in data.docs) {
        var snapshot = doc.data();
        if (snapshot['creator_id'] == auth.currentUser.uid)
          result.add(snapshot['category']);
      }
    });
    _category = result.toList();
    return _category;
  }

  Future fetchRestaurant() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    List<String> result = [];
    await firestore.collection('restaurants').get().then((data) {
      for (var doc in data.docs) {
        var snapshot = doc.data();
        if (snapshot['creator_id'] == auth.currentUser.uid) {
          result.add(snapshot['restaurant_name']);
        }
      }
    });
    _restaurant = result.toList();
    return _restaurant;
  }
}
