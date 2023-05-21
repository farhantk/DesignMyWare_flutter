import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> pesananDetails = [];

  Future<void> fetchData() async {
    final url = Uri.parse('http://10.50.16.2:8000/api/user/cart');
    final headers = {
      'Authorization': 'Bearer 2|ClNzdKqR0yQ2TgsIZCVTRGlY3OpY2Eq3L3tDIemq'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        pesananDetails =
            data['pesanan_details']['3']; // Ganti '3' dengan id yang sesuai
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;
    return Scaffold(
      body: ListView.builder(
        itemCount: pesananDetails.length,
        itemBuilder: (context, index) {
          final pesananDetail = pesananDetails[index];
          return Card(
            child: ListTile(
              title: Text('Product ID: ${pesananDetail['product_id']}'),
              subtitle:
                  Text('Jumlah Pesanan: ${pesananDetail['jumlah_pesanan']}'),
            ),
          );
        },
      ),
    );
  }
}
