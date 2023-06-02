import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/services/auth_service.dart';

import '../models/user_model.dart';
import '../services/cart_service.dart';

class CartProvider with ChangeNotifier {
  dynamic _cart;

  dynamic get cart => _cart;

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
      return cart;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> negotiatePrice({
    required int id,
    required int negotiatedPrice,
    required String token,
  }) async {
    try {
      dynamic response = await CartService().negotiatePrice(
        id: id,
        negotiatedPrice: negotiatedPrice,
        token: token,
      );
      return response;
    } catch (e) {
      return false;
    }
  }
}
