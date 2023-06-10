import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:provider/provider.dart';

// ignore: non_constant_identifier_names
class TransactionService {
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<dynamic> ShowExpedition() async {
    var url = '$baseUrl/expedition';
    var headers = {'Content-Type': 'application/json'};
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      throw Exception('Show transaction failed: $errorMessage');
    }
  }

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
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
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
    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
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
    required File paymentreceipt,
  }) async {
    var url = '$baseUrl/user/transaction/checkout';
    var headers = {'Authorization': token};
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll(headers);
    request.fields['id'] = id.toString();
    request.fields['name'] = name;
    request.fields['phone_number'] = phoneNumber;
    request.fields['province'] = province;
    request.fields['city'] = city;
    request.fields['subdistrict'] = subdistrict;
    request.fields['ward'] = ward;
    request.fields['street'] = street;
    request.fields['zip'] = zip;
    request.fields['courier'] = courier;
    request.files.add(await http.MultipartFile.fromPath(
      'paymentreceipt',
      paymentreceipt.path,
    ));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);
      print(jsonResponse);
      return jsonResponse;
    } else {
      var errorMessage = await response.stream.bytesToString();
      var errorResponse = jsonDecode(errorMessage);
      var error = errorResponse['message'];
      print(error);
      throw Exception('Show transaction failed: $error');
    }
  }
}
