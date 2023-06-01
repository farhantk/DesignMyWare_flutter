import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/services/auth_service.dart';

import '../models/user_model.dart';

class AuthProvider with ChangeNotifier{
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user){
    _user = user;
    notifyListeners();
  }

  Future<bool> SignUp({
    required String name, 
    required String email, 
    required String password, 
    required String confirmPassword
  }) async {
    try{
      UserModel user = await AuthService().SignUp(
        name: name, 
        email: email, 
        password: password, 
        confirmPassword: confirmPassword
      );
      _user = user;
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> SignIn({
    required String email, 
    required String password, 
  }) async {
    try{
      UserModel user = await AuthService().SignIn(
        email: email, 
        password: password, 
      );
      _user = user;
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> EditProfile({
    required int id, 
    required String email, 
    required String token, 
    String? name,
    String? phoneNumber,
    String? province,
    String? city,
    String? subdistrict,
    String? ward,
    String? street,
    String? zip,
  }) async {
    try{
      UserModel user = await AuthService().EditProfile(
        id: id,
        token: token,
        email: email, 
        name: name, 
        phoneNumber:phoneNumber,
        province:province,
        city:city,
        subdistrict:subdistrict,
        ward:ward,
        street:street,
        zip:zip, 
      );
      
      _user = user;
      return true;
    }catch(e){
      return false;
    }
  }
}