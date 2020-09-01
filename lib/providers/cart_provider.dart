import 'package:delivery_food/models/cart_model.dart';
import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItemModel> _cartProducts = {};

  Map<String, CartItemModel> get cartProducts => _cartProducts;
  int get itemCount => _cartProducts.length;
  double get totalAmount {
    var total = 0.0;
    _cartProducts.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  bool findById(String id) {
    return _cartProducts.containsKey(id);
  }

  int get getQuantity {
    var total = 0;
    _cartProducts.forEach(
      (key, cartItem) {
        total += cartItem.quantity;
      },
    );
    return total;
  }

  void addProductToCart(
      String productId, String title, double price, String img, int quantity) {
    if (_cartProducts.containsKey(productId)) {
      _cartProducts.update(
        productId,
        (exCartItem) => CartItemModel(
          id: exCartItem.id,
          quantity: quantity,
          img: exCartItem.img,
          price: exCartItem.price,
          title: exCartItem.title,
        ),
      );
    } else {
      _cartProducts.putIfAbsent(
        productId,
        () => CartItemModel(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          img: img,
          quantity: quantity,
        ),
      );
    }

    notifyListeners();
  }

  void clearCart() {
    _cartProducts.clear();
    notifyListeners();
  }
}
// _cartProducts.update(
// productId,
// (exProductCart) => CartItemModel(
// id: exProductCart.id,
// title: exProductCart.title,
// price: exProductCart.price,
// img: exProductCart.img,
// quantity: exProductCart.quantity + 1,
// ),
// );
