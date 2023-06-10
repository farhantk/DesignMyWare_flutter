import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/services/auth_service.dart';

import '../models/user_model.dart';
import '../services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  dynamic _order;
  dynamic _track;
  dynamic _expedition;

  dynamic get order => _order;
  dynamic get track => _track;
  dynamic get expedition => _expedition;

  set order(dynamic order) {
    _order = order;
    notifyListeners();
  }

  Future<dynamic> Showtransaction({
    required int id,
    required String token,
  }) async {
    try {
      dynamic order = await TransactionService().ShowTransaction(
        id: id,
        token: token,
      );
      _order = order;
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<dynamic> Checkout({
    required int id,
    required String token,
    required String name,
    required String phoneNumber,
    required String province,
    required String city,
    required String subdistrict,
    required String ward,
    required String street,
    required String zip,
    required String courier,
    required String paymentreceipt,

  }) async {
    try {
      print('cek cek');
      dynamic checkout = await TransactionService().Checkout(
        id: id,
        token: token,
        name: name,
        phoneNumber: phoneNumber,
        province: province,
        city: city,
        subdistrict: subdistrict,
        ward: ward,
        street: street,
        zip: zip,
        courier: courier,
        paymentreceipt: paymentreceipt,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> ShowExpedition() async {
    try {
      dynamic expedition = await TransactionService().ShowExpedition();
      _expedition = expedition;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> Track({
    required String courierName,
    required String receipt_code,
    required String token,
  }) async {
    try {
      print('hey');
      dynamic track = await TransactionService().Track(
        courierName: courierName,
        receipt_code: receipt_code,
        token: token,
      );
      _track = track;
      print(_track);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> Finish({
    required int orderId,
    required String token,
  }) async {
    try {
      dynamic finish = await TransactionService().Finish(
        orderId: orderId,
        token: token,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

}
