import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tubesflutter/pages/detail_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> products = [];

  Future<void> getProduct() async {
    final url = Uri.parse('http://localhost:8000/api/product');
    // final headers = {
    //   'Authorization': 'Bearer 2|ClNzdKqR0yQ2TgsIZCVTRGlY3OpY2Eq3L3tDIemq'
    // };

    final response = await http.get(
      url,
      // headers: headers
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        products = data['data'];
        print(products); // Ganti '3' dengan id yang sesuai
      });
    } else {
      throw Exception('Failed to get product data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final x = products[index];
          return InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailProduct(
                            product_id: x['id'],
                          )));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(x['name']),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(x['desc']),
                  ),
                  Text(NumberFormat.currency(
                    locale: 'ID',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(x['price'])),
                ],
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300, crossAxisSpacing: 10, mainAxisSpacing: 10),
      ),
    );
  }
}
