// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tubesflutter/pages/homepage.dart';

class DetailProduct extends StatefulWidget {
  final int product_id;
  const DetailProduct({Key? key, required this.product_id}) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  TextEditingController jumlahController = TextEditingController();
  String jumlah = '1';
  bool kantong = false;
  bool zipper = false;
  List<dynamic> product = [];

  Future<void> getProduct() async {
    final url = Uri.parse('http://localhost:8000/api/product/detail');
    // final headers = {
    //   'Authorization': 'Bearer 2|ClNzdKqR0yQ2TgsIZCVTRGlY3OpY2Eq3L3tDIemq'
    // };

    final response =
        await http.post(url, body: {'product_id': widget.product_id.toString()}
            // headers: headers
            );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        product = data['data'];
        // print(product); // Ganti '3' dengan id yang sesuai
      });
    } else {
      throw Exception('Failed to get product data');
    }
  }

  Widget total(int price) {
    var totalHarga = 0;
    var tempCount = 0;

    int kantongPrice = 2000; //harga default tambahan kantong
    int zipperPrice = 2000; //harga default tambahan zipper
    int discountPerpc = 50; //discount setiap 50 pc
    int discount = 500; //jumlah pengurangan harga item per pc

    if (jumlah != '') {
      var checkPembagian = int.parse(jumlah) / discountPerpc; //jumlah item misalkan 20 dibagi 50 apakah tidak 0
      var jumlahPembagian = checkPembagian.toString().split('.');
      if (int.parse(jumlahPembagian[0]) > 0) { //if hasil pembagian lebih besar dari 0
        if (kantong == true) {
          price += kantongPrice; //harga awal ditambah harga kantong

          totalHarga = (price - (int.parse(jumlahPembagian[0]) * discount)) *
              int.parse(jumlah);
        }
        if (zipper == true) {
          price += zipperPrice; //harga awal ditambah harga zipper

          totalHarga = (price - (int.parse(jumlahPembagian[0]) * discount)) *
              int.parse(jumlah);
        }
        if(kantong == true && zipper == true){
          price += kantongPrice; //harga awal ditambah harga kantong
          price += zipperPrice; //harga awal ditambah harga zipper

          totalHarga = (price - (int.parse(jumlahPembagian[0]) * discount)) *
              int.parse(jumlah);
          // (harga awal - (1.24 = 1 x 500)) * jumlah item  
        }

        totalHarga = (price - (int.parse(jumlahPembagian[0]) * discount)) *
            int.parse(jumlah);
      } else {
        if (kantong == true) {
          price += kantongPrice;
          totalHarga = price * int.parse(jumlah);
        }
        if (zipper == true) {
          price += kantongPrice;
          totalHarga = price * int.parse(jumlah);
        }

        totalHarga = price * int.parse(jumlah);
      }
    } else {
      totalHarga = 0;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          constraints: BoxConstraints(minHeight: 50, minWidth: double.infinity),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.blue),
          child: Center(
              child: Text(
            "Total: " + NumberFormat.currency(
                        locale: 'ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(totalHarga),
            style: TextStyle(color: Colors.white, fontSize: 25),
          )),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
    setState(() {
      jumlahController.text = jumlah;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    jumlahController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Product"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              // Navigator.pop(context);
               Navigator.pushNamed(context, '/home');
            }),
      ),
      body: ListView.builder(
          itemCount: product.length,
          itemBuilder: (context, index) {
            final x = product[index];
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(x['name']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(x['desc']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(
                        locale: 'ID',
                        symbol: 'Rp ',
                        decimalDigits: 0,
                      ).format(x['price']),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('Hitung Harga')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (e) {
                        if (e!.isEmpty) {
                          return "Jumlah tidak boleh kosong";
                        }
                      },
                      onChanged: (newValue) {
                        setState(() {
                          jumlah = newValue;
                        });
                        // print(newValue);
                      },
                      // onSaved: (e) => jumlah = e!,
                      controller: jumlahController,
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: "Jumlah",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        hintStyle: TextStyle(
                          color: Color(0xFF404040),
                        ),
                        // suffixIcon: IconButton(
                        //   onPressed: () {
                        //     // widget.controller!.clear();
                        //     // setState(() {
                        //     //   kelurahanId = 0;
                        //     // });
                        //   },
                        //   icon: const Icon(Icons.cancel_sharp),
                        // ),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: Text("Kantong"),
                    value: kantong,
                    onChanged: (newValue) {
                      setState(() {
                        kantong = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  CheckboxListTile(
                    title: Text("Zipper"),
                    value: zipper,
                    onChanged: (newValue) {
                      setState(() {
                        zipper = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  total(x['price'])
                ],
              ),
            );
          }),
    );
  }
}
