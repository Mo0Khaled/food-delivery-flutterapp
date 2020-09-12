import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_food/models/cart_model.dart';
import 'package:delivery_food/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class OrderProvider with ChangeNotifier {
  List<OrderItemModel> _orders = [];

  List<OrderItemModel> get orders => _orders;
  LocationData coordinates;

  Future fetchOrders() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    final List<OrderItemModel> getOrders = [];
    var documents = await firestore
        .collection("orders")
        .where("id", isEqualTo: auth.currentUser.uid)
        .get();
    for (var document in documents.docs) {
      print(document.data());
      getOrders.add(OrderItemModel(
//          idToken: null,
//          latitude:document.data()["lat"] ,
//          longitude: document.data()["long"],
          amount: document.data()["amount"],
          id: document.id,
          dateTime: DateTime.parse(document.data()['dateTime']),
          productsToOrder: (document.data()["products"] as List<dynamic>)
              .map((product) => CartItemModel(
                  id: product["id"],
                  price: product["price"],
                  title: product["title"],
                  quantity: product["quantity"],
                  img: product["img"]))
              .toList()));
    }
    _orders = getOrders.reversed.toList();
    notifyListeners();
  }

//
//  Future fetchOrders() async {
//    FirebaseFirestore firestore = FirebaseFirestore.instance;
//    FirebaseAuth auth = FirebaseAuth.instance;
//    final List<OrderItemModel> getOrders = [];
//    firestore
//        .collection("orders").where("id",isEqualTo: auth.currentUser.uid)
//        .get()
//        .then((document) {
//      getOrders.add(OrderItemModel(
//          amount: document.data()["amount"],
//          id: document.id,
//          dateTime: DateTime.parse(document.data()['dateTime']),
//          productsToOrder: (document.data()["products"] as List<dynamic>)
//              .map((product) => CartItemModel(
//                  id: product["id"],
//                  price: product["price"],
//                  title: product["title"],
//                  quantity: product["quantity"],
//                  img: product["img"]))
//              .toList()));
//
//      _orders = getOrders.reversed.toList();
////      print(_orders[0].dateTime);
////      print(_orders[1].dateTime);
//      notifyListeners();
//    });
//  }
//  var data = await firestore.collection("orders").doc(auth.currentUser.uid).get() ;
//  data.data().forEach((orderId, myOrders) {
//  getOrders.add(
//  OrderItemModel(
//  id: orderId,
//  amount: myOrders['amount'],
//  dateTime:DateTime.parse( myOrders['dateTime']),
//  productsToOrder: (myOrders['products'] as List<dynamic>)
//      .map(
//  (sItem) => CartItemModel(
//  id: sItem['id'],
//  title: sItem['title'],
//  price: sItem['price'],
//  img: sItem['img'],
//  quantity: sItem['quantity'],
//  ),
//  )
//      .toList(),
//  ),
//  );
//  });
  Future<void> addOrder(List<CartItemModel> cartProducts, double total) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    await firestore.collection("orders").doc().set({
//      "idToken":null,
//      "lat":coordinates.latitude,
//      "long":coordinates.longitude,
      "id": auth.currentUser.uid,
      'amount': total,
      'dateTime': DateTime.now().toIso8601String(),
      'products': cartProducts
          .map((cp) => {
                'id': cp.id,
                'title': cp.title,
                'price': cp.price,
                'quantity': cp.quantity,
                'img': cp.img,
              })
          .toList(),
    });

//  Future<void> addOrder(List<CartItemModel> cartProducts, double total) async {
//    FirebaseFirestore firestore = FirebaseFirestore.instance;
//    FirebaseAuth auth = FirebaseAuth.instance;
//    await firestore.collection("orders").doc(auth.currentUser.uid).set({
//      'amount': total,
//      'dateTime': DateTime.now().toIso8601String(),
//      'products': cartProducts
//          .map((cp) => {
//                'id': cp.id,
//                'title': cp.title,
//                'price': cp.price,
//                'quantity': cp.quantity,
//                'img': cp.img,
//              })
//          .toList(),
//    });
    // _orders.insert(0, OrderItemModel(
    //   id: firestore.doc(cartProducts.).id,
    //   dateTime:
    // ),);
//    notifyListeners();
  }
}
