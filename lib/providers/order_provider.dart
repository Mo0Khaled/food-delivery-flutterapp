import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_food/models/cart_model.dart';
import 'package:delivery_food/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  List<OrderItemModel> _orders = [];

  List<OrderItemModel> get orders => _orders;

  Future<List<OrderItemModel>> fetchOrders() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    final List<OrderItemModel> getOrders = [];
    var data = await firestore.collection("orders").doc(auth.currentUser.uid).get() ;
    data.data().forEach((orderId, myOrders) {
      getOrders.add(
        OrderItemModel(
          id: orderId,
          amount: myOrders['amount'],
          dateTime:DateTime.parse( myOrders['dateTime']),
          productsToOrder: (myOrders['products'] as List<dynamic>)
              .map(
                (sItem) => CartItemModel(
              id: sItem['id'],
              title: sItem['title'],
              price: sItem['price'],
              img: sItem['img'],
              quantity: sItem['quantity'],
            ),
          )
              .toList(),
        ),
      );
    });
    _orders = getOrders.reversed.toList();
    return _orders;
  }

  Future<void> addOrder(List<CartItemModel> cartProducts, double total) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    await firestore.collection("orders").doc(auth.currentUser.uid).set({
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
    // _orders.insert(0, OrderItemModel(
    //   id: firestore.doc(cartProducts.).id,
    //   dateTime:
    // ),);
    notifyListeners();
  }
}
