import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/pages/signup.dart';
import 'package:image_picker/image_picker.dart';

import '../Theme/theme.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/transaction_provider.dart';
import 'landingpage.dart';
import 'profile.dart';
import 'package:http/http.dart' as http;

class CheckOutPage extends StatefulWidget{
  const CheckOutPage({super.key});
  @override
  State<StatefulWidget> createState() => _CheckOutPageState();

}
class _CheckOutPageState extends State<StatefulWidget>{
  
  final _picker = ImagePicker();
  late File _imageFile;

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  


  @override
    void initState() {
      super.initState();
    }
  Key _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider = Provider.of<TransactionProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    TextEditingController nameController = TextEditingController(text: user.name);
    TextEditingController phoneNumberController = TextEditingController(text: user.phone_number);
    TextEditingController provinceController = TextEditingController(text: user.province);
    TextEditingController cityController = TextEditingController(text: user.city);
    TextEditingController subdistrictController = TextEditingController(text: user.subdistrict);
    TextEditingController wardController = TextEditingController(text: user.ward);
    TextEditingController streetController = TextEditingController(text: user.street);
    TextEditingController zipController = TextEditingController(text: user.zip);

    var expedition = transactionProvider.expedition;
    var expeditions = expedition['expeditions'];

    TextEditingController courierController = TextEditingController(text: expeditions[0]['name']);
    handleCheckout() async{
      // Mengambil path dari file gambar
      String imagePath = _imageFile.path;

      // Membuka file gambar
      var imageFile = File(imagePath);

      // Membaca konten gambar
      List<int> imageBytes = await imageFile.readAsBytes();

      // Mengencode konten gambar ke base64
      String base64Image = base64Encode(imageBytes);
      
      bool response = await transactionProvider.Checkout(
        id: user.id!, 
        token: user.token!,
        name: nameController.text, 
        phoneNumber:phoneNumberController.text,
        province:provinceController.text,
        city:cityController.text,
        subdistrict:subdistrictController.text,
        ward:wardController.text,
        street:streetController.text,
        zip:zipController.text,
        courier:courierController.text,
        paymentreceipt: File('fsd')
      );
      if(response){
        Navigator.pushNamed(context, '/home');
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor('#ED2B2A'),
            content: Text(
              'Gagal mengganti profil anda',
              textAlign: TextAlign.center,
            ),
          )
        );
      }
    }
    
    Future<void> getCartDetails() async {
      await cartProvider.showCart(
        id: user.id!,
        token: user.token!,
      );
    }

    dynamic pesanan = cartProvider.cart;
    print(pesanan);
    List<Map<String, dynamic>> _cartItems = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black45),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  height: constraints.maxHeight,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      FutureBuilder(
                        future: getCartDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            _cartItems = List<Map<String, dynamic>>.from(pesanan['pesanan_details']);
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _cartItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                final item = _cartItems[index];
                                return Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0), // Adjust the spacing between rows here
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${item['product_name']} x ${item['jumlah_pesanan']}'),
                                      Text('Rp. ${item['subtotal']}'),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Divider(thickness: 1),
                      ),
                      Align(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Harga yang harus dibayar',
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                'Rp. ${pesanan['total_harga']}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SafeArea(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 1, 20, 10),
                          margin: EdgeInsets.fromLTRB(20, 1, 20, 10),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Align(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Data diri',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: TextFormField(
                                        controller: nameController,
                                        decoration: theme().textInputDecoration('Nama', 'Masukan nama'),
                                      ),
                                      decoration: theme().inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: TextFormField(
                                        controller: phoneNumberController,
                                        decoration: theme().textInputDecoration('No HP', 'Masukan nomor HP'),
                                      ),
                                      decoration: theme().inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 20.0),
                                    Align(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Alamat',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 0),
                                      child: Divider(thickness: 1),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: TextFormField(
                                        controller: provinceController,
                                        decoration: theme().textInputDecoration('Provinsi', 'Masukan provinsi'),
                                      ),
                                      decoration: theme().inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: TextFormField(
                                        controller: cityController,
                                        decoration: theme().textInputDecoration('Kota/Kab', 'Masukan kota/kab'),
                                      ),
                                      decoration: theme().inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: TextFormField(
                                        controller: subdistrictController,
                                        decoration: theme().textInputDecoration('Kecamatan', 'Masukan kecamatan'),
                                      ),
                                      decoration: theme().inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: TextFormField(
                                        controller: wardController,
                                        decoration: theme().textInputDecoration('Kelurahan', 'Masukan kelurahan'),
                                      ),
                                      decoration: theme().inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: TextFormField(
                                        controller: streetController,
                                        decoration: theme().textInputDecoration('Alamat Lengkap', 'Masukan alamat lengkap'),
                                      ),
                                      decoration: theme().inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: TextFormField(
                                        controller: zipController,
                                        decoration: theme().textInputDecoration('Kode Pos', 'Masukan kode pos'),
                                      ),
                                      decoration: theme().inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      child: DropdownButtonFormField<String>(
                                        decoration: theme().textInputDecoration('Pengiriman', 'Pilih jasa pengiriman'),
                                        value: courierController.text,
                                        onChanged: (newValue) {
                                          setState(() {
                                            courierController.text = newValue!;
                                          });
                                        },
                                        items: expedition['expeditions'].map<DropdownMenuItem<String>>((expedition) {
                                          return DropdownMenuItem<String>(
                                            value: expedition['name'],
                                            child: Text(expedition['name']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Align(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0,10, 20, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Pembayaran',
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  Colors.black),
                                            ),
                                          ]
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Align(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0,10, 20, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'BCA a.n deignmyware',
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color:  Colors.black),
                                                ),
                                                Text(
                                                  '432423652',
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color:  Colors.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'BNI a.n deignmyware',
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color:  Colors.black),
                                                ),
                                                Text(
                                                  '543645754',
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color:  Colors.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'BSI a.n deignmyware',
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color:  Colors.black),
                                                ),
                                                Text(
                                                  '967535633',
                                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color:  Colors.black),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 20,
                                            offset: const Offset(0, 5),
                                          )
                                        ],
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey.shade400),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Bukti Pembayaran',
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  Colors.grey),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // TODO: Tambahkan kode untuk mengambil gambar dari galeri
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Theme.of(context).primaryColor,
                                              ),
                                              child: Text(
                                                'Pilih Gambar',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Container(
                                      decoration: theme().buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: theme().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                          child: Text('Proses pesanan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                        ),
                                        onPressed: () {
                                          // Setelah login berhasil, kita akan mengarahkan ke halaman profil. Mari buat halaman profil sekarang.
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}