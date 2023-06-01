import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/services/auth_service.dart';

import '../models/user_model.dart';
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
    required int id,
    required String token,
  }) async {
    try {
      dynamic cart = await CartService().ShowCart(
        id: id,
        token: token,
      );
      _cart = cart;
      return true;
    } catch (e) {
      return false;
    }
  }
}
