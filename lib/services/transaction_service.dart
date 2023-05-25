import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
class TransactionService {
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<dynamic> ShowTransaction({
    required int id,
    required String token,
  }) async {
    var url = '$baseUrl/user/transaction';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      throw Exception('Show transaction failed: $errorMessage');
    }
  }

  Future<dynamic> Track({
    required String courierName,
    required String receipt_code,
    required String token,
  }) async {
    var url = '$baseUrl/user/transaction/track';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({
      'courier': courierName,
      'receipt_code': receipt_code,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body
      );
    print(body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      print(errorMessage);
      throw Exception('Show transaction failed: $errorMessage');
    }
  }

  Future<dynamic> Finish({
    required int orderId,
    required String token,
  }) async {
    var url = '$baseUrl/user/transaction/finish';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({
      'orderId': orderId,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body
      );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      print(errorMessage);
      throw Exception('Show transaction failed: $errorMessage');
    }
  }
}
