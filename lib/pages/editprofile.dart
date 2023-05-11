import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tubesflutter/pages/signup.dart';

import '../Theme/theme.dart';
import 'landingpage.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({super.key});
  @override
  State<StatefulWidget> createState() => _EditProfilePageState();

}

class _EditProfilePageState extends State<StatefulWidget>{
  Key _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'email@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(thickness: 1),
              ),
              SafeArea(
                child: Container( 
                  padding: EdgeInsets.fromLTRB(20, 1, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 1, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  decoration: theme().textInputDecoration('Email', 'Masukan email anda'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
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
                              SizedBox(height: 50.0),
                              Container(
                                decoration: theme().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: theme().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                                    child: Text('Simpan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
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