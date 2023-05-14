import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tubesflutter/pages/signup.dart';
import 'package:image_picker/image_picker.dart';

import '../Theme/theme.dart';
import 'landingpage.dart';
import 'profile.dart';


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
  
  final List<Map<String, dynamic>> _cartItems = 
  [
      {'name': 'Sepatu Sneakers',
      'image': 'assets/images/sneakers.jpg',
      'price': 750000,
      'quantity': 1,
      },    
      {'name': 'Tas Ransel',
      'image': 'assets/images/backpack.jpg',
      'price': 300000,
      'quantity': 2,
      },
  ];
  Key _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: _cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = _cartItems[index];
                  return ListTile(
                    leading: Image.asset(
                      item['image'],
                      width: 64,
                      height: 64,
                    ),
                    title: Text(item['name']),
                    subtitle: Text('${item['quantity']}x ${item['price']}'),
                    trailing: Text('Rp. ${item['quantity']*item['price']}'),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(thickness: 1),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20,10, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Harga yang harus dibayar',
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        'Rp. 1000000',
                        style: TextStyle(color: Colors.black),
                      ),
                    ]
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
                                  padding: EdgeInsets.fromLTRB(0,10, 20, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Data diri',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  Colors.black),
                                      ),
                                    ]
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: theme().textInputDecoration('Nama Lengkap', 'Masukan nama lengkap'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: theme().textInputDecoration('No HP', 'Masukan nomor HP'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 20.0),
                              Align(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0,10, 20, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Alamat',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:  Colors.black),
                                      ),
                                    ]
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Divider(thickness: 1),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: theme().textInputDecoration('Provinsi', 'Masukan provinsi'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: theme().textInputDecoration('Kota/Kab', 'Masukan kota/kab'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: theme().textInputDecoration('Kecamatan', 'Masukan kecamatan'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: theme().textInputDecoration('Kelurahan', 'Masukan kelurahan'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: theme().textInputDecoration('Alamat Lengkap', 'Masukan alamat lengkap'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: theme().textInputDecoration('Kode Pos', 'Masukan kode pos'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
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
                              SizedBox(height: 30.0),
                              Container(
                                decoration: theme().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: theme().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                                    child: Text('Proses pesanan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: (){
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
                                  },
                                ),
                              ),
                              
                            ],
                          )
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}