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
  void initState() {
    super.initState();
    fetchCartDetails();
  }

  Future<void> fetchCartDetails() async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    bool success = await cartProvider.showCart(
        token: 'Bearer 11|I0iASnSVc3bPWQYZ1h5dylLRdec0fNwTd2Fdv9s6');
    if (success) {
      print('Cart details fetched successfully');
    } else {
      print('Failed to fetch cart details');
    }
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    dynamic cartDetails = cartProvider.cartDetail;

    return Scaffold(
      body: cartDetails == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cartDetails.length,
              itemBuilder: (context, index) {
                dynamic cartDetail = cartDetails[index];
                return Card(
                  child: ListTile(
                    title: Text('Product ID: ${cartDetail['product_id']}'),
                    subtitle:
                        Text('Jumlah Pesanan: ${cartDetail['jumlah_pesanan']}'),
                  ),
                );
              },
            ),
    );
  }
}
