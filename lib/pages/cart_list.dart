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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<CartProvider>(
          // Use Consumer to access the CartProvider instance
          builder: (context, cartProvider, _) {
            return FutureBuilder<dynamic>(
              future: cartProvider.showCart(
                // Call showCart on the CartProvider instance
                id: user.id!,
                token: user.token!,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.hasData) {
                    dynamic cartData = snapshot.data;
                    List<dynamic> cartItems = cartData['pesanan_details'];

                    return ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        dynamic cartItem = cartItems[index];
                        int no = cartItem['no'];
                        String productName = cartItem['product_name'];
                        int jumlahPesanan = cartItem['jumlah_pesanan'];
                        int productPrice = cartItem['product_price'];
                        int subtotal = cartItem['subtotal'];
                        String statusNego = cartItem['status_nego'];
                        int hargaNego = cartItem['harga_nego'];

                        return ListTile(
                          title: Text('No: $no'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Product Name: $productName'),
                              Text('Jumlah Pesanan: $jumlahPesanan'),
                              Text('Product Price: $productPrice'),
                              Text('Subtotal: $subtotal'),
                              Text('Status Nego: $statusNego'),
                              Text('Harga Nego: $hargaNego'),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('No data available.');
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
