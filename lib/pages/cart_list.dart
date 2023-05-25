import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Future<void> getCartDetails() async {
      await cartProvider.showCart(
        token: user.token!,
      );
    }

    dynamic cartDetails = cartProvider.cartDetail;
    List<dynamic> cartDetail = [];
    if (cartDetails != null) {
      // cartDetail = cartDetail['cartDetail'];
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Color.fromARGB(255, 118, 118, 118),
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 3, 134, 0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(children: [
                                Column(children: [
                                  Text("NAMA PRODUK",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 43, 43, 43),
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Row(children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Harga",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ),
                                      SizedBox(width: 20),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("[Jumlah]x",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ),
                                      SizedBox(width: 20),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Total Harga",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ),
                                      SizedBox(width: 20),
                                    ]),
                                  )
                                ]),
                              ]),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
                  padding: EdgeInsets.fromLTRB(40, 10, 80, 10),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        child: Row(children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Ajukan Negoisasi",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 43, 43, 43),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          SizedBox(width: 100),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text("Status",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 73, 255, 73),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Masukan Harga Negoisasi',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text('Nego'),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor:
                                      Color.fromARGB(255, 3, 134, 0),
                                  onSurface: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () {},
                                child: Text('Hapus'),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor:
                                      Color.fromARGB(255, 134, 4, 4),
                                  onSurface: Colors.grey,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ]),
            ),
            SizedBox(height: 50),
            Container(
              height: 10,
              color: Color.fromARGB(255, 146, 146, 146),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("TOTAL PEMBAYARAN",
                        style: TextStyle(
                            color: Color.fromARGB(255, 82, 80, 80),
                            fontSize: 25)),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Rp 10.000.000",
                        style: TextStyle(
                          color: Color.fromARGB(255, 82, 80, 80),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
