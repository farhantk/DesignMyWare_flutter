import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import 'checkout.dart';

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: FutureBuilder<dynamic>(
        future: cartProvider.showCart(
          id: user.id!,
          token: user.token!,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              dynamic cartData = snapshot.data;
              List<dynamic> cartItems = cartData['pesanan_details'];

              int totalPrice = cartData['total_harga'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        dynamic cartItem = cartItems[index];
                        int id = cartItem['id'];
                        int no = cartItem['no'];
                        String productName = cartItem['product_name'];
                        int jumlahPesanan = cartItem['jumlah_pesanan'];
                        int productPrice = cartItem['product_price'];
                        int subtotal = cartItem['subtotal'];
                        String statusNego = cartItem['status_nego'];
                        int hargaNego = cartItem['harga_nego'];

                        return Card(
                          color: Colors.white,
                          child: InkWell(
                            child: Container(
                              padding: EdgeInsets.only(left: 20, top: 15),
                              margin: EdgeInsets.only(
                                  bottom: 40, left: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$productName',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 28),
                                  ),
                                  Text(
                                    'Harga Item : $productPrice',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Text(
                                    'Jumlah Pesanan : $jumlahPesanan',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Text(
                                    'Status Nego : $statusNego',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Text(
                                    'Total Harga Pesanan : $hargaNego',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              int negotiatedPrice =
                                                  productPrice; // Default value

                                              return AlertDialog(
                                                title: Text('Negosiasi Harga'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                        'Total Harga: $subtotal'),
                                                    SizedBox(height: 10),
                                                    TextField(
                                                      decoration: InputDecoration(
                                                          labelText:
                                                              'Harga Negosiasi'),
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        negotiatedPrice =
                                                            int.parse(value);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      bool negotiationSuccess =
                                                          await cartProvider
                                                              .negotiatePrice(
                                                        id: id,
                                                        negotiatedPrice:
                                                            negotiatedPrice,
                                                        token: user.token!,
                                                      );

                                                      if (negotiationSuccess) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Sukses'),
                                                              content: Text(
                                                                  'Negosiasi berhasil. Silakan tunggu konfirmasi admin.'),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'OK'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title:
                                                                  Text('Error'),
                                                              content: Text(
                                                                  'Negosiasi gagal.'),
                                                              actions: [
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      'OK'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: Text('Ajukan'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Handle cancel button click event
                                                      // You can perform any action here, such as resetting the negotiated price
                                                      // Remember to close the dialog
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Batal'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors
                                              .green, // Ubah warna latar belakang tombol Negosiasi
                                        ),
                                        child: Text('Negosiasi'),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () async {
                                          bool confirmDelete = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Konfirmasi'),
                                                content: Text(
                                                    'Apakah Anda yakin ingin menghapus item ini?'),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Mengembalikan nilai `true` jika pengguna ingin menghapus item
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    child: Text('Ya'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Mengembalikan nilai `false` jika pengguna tidak ingin menghapus item
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text('Tidak'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          if (confirmDelete == true) {
                                            bool deleteSuccess =
                                                await cartProvider
                                                    .deleteCartItem(
                                              id: id,
                                              token: user.token!,
                                            );

                                            if (deleteSuccess) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Item successfully deleted.'),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Failed to delete item.'),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        child: Text('Hapus'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TOTAL PEMBAYARAN",
                          style: TextStyle(
                            color: Color.fromARGB(255, 82, 80, 80),
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Rp $totalPrice",
                          style: TextStyle(
                            color: Color.fromARGB(255, 82, 80, 80),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckOutPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .green, // Ubah warna latar belakang tombol Negosiasi
                          ),
                          child: Text('Bayar Sekarang'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Text('No data available.');
            }
          }
        },
      )),
    );
  }
}


// Text('Status Nego: $statusNego'),
// Text('Harga Nego: $hargaNego'),

