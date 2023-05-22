import 'package:flutter/material.dart';

import '../services/cart_service.dart';

class CartProvider with ChangeNotifier {
  dynamic _cart;
  dynamic _cartDetail;

  dynamic get cart => _cart;
  dynamic get cartDetail => _cartDetail;

  set cart(dynamic cart) {
    _cart = cart;
    notifyListeners();
  }

  Future<dynamic> showCart({
    required String token,
  }) async {
    try {
      dynamic cart = await cartService().ShowCart(
        token: token,
      );
      _cart = cart;
      return true;
    } catch (e) {
      return false;
    }
  }
}
