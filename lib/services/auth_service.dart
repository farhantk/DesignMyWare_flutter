import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:provider/provider.dart';

class AuthService {
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<UserModel> SignUp(
      {required String name,
      required String email,
      required String password,
      required String confirmPassword}) async {
    var url = '$baseUrl/signup';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'confirm-password': confirmPassword
    });
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);
      user.token = 'Bearer ' + data['access_token'];
      return user;
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      throw Exception('SignUp failed: $errorMessage');
    }
  }

  Future<UserModel> SignIn({
    required String email,
    required String password,
  }) async {
    var url = '$baseUrl/signin';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'email': email, 'password': password});
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);
      user.token = 'Bearer ' + data['access_token'];
      print(user);
      return user;
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      throw Exception('SignIn failed: $errorMessage');
    }
  }

  Future<UserModel> EditProfile({
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
    var url = '$baseUrl/user/editprofile';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({
      'id': id,
      'email': email,
      'name': name,
      'phone_number': phoneNumber,
      'province': province,
      'city': city,
      'subdistrict': subdistrict,
      'ward': ward,
      'street': street,
      'zip': zip,
    });
    var response = await http.put(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      throw Exception('Change profile failed: $errorMessage');
    }
  }
}
