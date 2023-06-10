import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/pages/signup.dart';

import '../Theme/theme.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import 'landingpage.dart';
import 'profile.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({super.key});
  @override
  State<StatefulWidget> createState() => _EditProfilePageState();

}

class _EditProfilePageState extends State<StatefulWidget>{
  Key _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    TextEditingController nameController = TextEditingController(text: user.name);
    TextEditingController phoneNumberController = TextEditingController(text: user.phone_number);
    TextEditingController provinceController = TextEditingController(text: user.province);
    TextEditingController cityController = TextEditingController(text: user.city);
    TextEditingController subdistrictController = TextEditingController(text: user.subdistrict);
    TextEditingController wardController = TextEditingController(text: user.ward);
    TextEditingController streetController = TextEditingController(text: user.street);
    TextEditingController zipController = TextEditingController(text: user.zip);
    print(user.id);
    print(user.email);
    print(user.token);
    handleEditProfile() async{
      bool response = await authProvider.EditProfile(
        id: user.id!, 
        token: user.token!,
        email: user.email!, 
        name: nameController.text, 
        phoneNumber:phoneNumberController.text,
        province:provinceController.text,
        city:cityController.text,
        subdistrict:subdistrictController.text,
        ward:wardController.text,
        street:streetController.text,
        zip:zipController.text, 
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('http://192.168.1.2:8000/storage/${user?.photo}'),
              ),
              SizedBox(height: 20),
              Text(
                '${user.name}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${user.email}',
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
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: theme().textInputDecoration('Nama Lengkap', 'Masukan nama lengkap'),
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
                              SizedBox(height: 10.0),
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
                              SizedBox(height: 50.0),
                              Container(
                                decoration: theme().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: theme().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                                    child: Text('Simpan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: handleEditProfile,
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