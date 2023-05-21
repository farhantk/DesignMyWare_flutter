import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart List',
      theme: ThemeData(primarySwatch: Colors.green),
      home: CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
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
