import 'package:http/http.dart' as http;
import 'dart:convert';

class CartService {
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<dynamic> ShowCart({
    required int id,
    required String token,
  }) async {
    var url = '$baseUrl/user/cart';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      throw Exception('Show cart failed: $errorMessage');
    }
  }

  Future<dynamic> negotiatePrice({
    required int id,
    required int negotiatedPrice,
    required String token,
  }) async {
    var url = '$baseUrl/user/cart/$id/negotiation';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = {'harga': negotiatedPrice.toString()};
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      throw Exception('Negotiation failed: $errorMessage');
    }
  }

  Future<dynamic> deleteCartItem({
    required int id,
    required String token,
  }) async {
    var url = '$baseUrl/user/cart/$id/delete';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    final response = await http.delete(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      var errorResponse = jsonDecode(response.body);
      var errorMessage = errorResponse['message'];
      throw Exception('Delete cart item failed: $errorMessage');
    }
  }
}
