import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/services/auth_service.dart';

import '../models/user_model.dart';
import '../services/transaction_service.dart';

class TransactionProvider with ChangeNotifier{
  dynamic _order;
  dynamic _track;

  dynamic get order => _order;
  dynamic get track => _track;

  set order(dynamic order){
    _order = order;
    notifyListeners();
  }

  Future<dynamic> Showtransaction({
    required int id, 
    required String token, 
  }) async {
    try{
      dynamic order = await TransactionService().ShowTransaction(
        id: id,
        token: token,
      );
      _order = order;
      return true;
    }catch(e){
      return false;
    }
  }
  Future<dynamic> Track({
    required String courierName, 
    required String receipt_code, 
    required String token, 
  }) async {

    try{
      print('hey');
      dynamic track = await TransactionService().Track(
        courierName: courierName,
        receipt_code: receipt_code,
        token: token,
      );
      _track = track;
      print(_track);
      return true;
    }catch(e){
      return false;
    }
  }
}