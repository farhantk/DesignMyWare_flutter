import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Theme/theme.dart';
import 'profile.dart';
import 'signin.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({super.key});
  @override
  State<StatefulWidget> createState() => _SignUpPageState();

}

class _SignUpPageState extends State<StatefulWidget>{
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/signup_bg.png"), // ganti dengan path ke gambar latar belakang yang ingin digunakan
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SafeArea(
                child: Container( 
                  padding: EdgeInsets.fromLTRB(20, 150, 20, 130),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(40, 0, 40, 20),
                          child: Center(
                            child: Image.asset('assets/images/logo.png'),
                          ),
                        ),
                      ),
                      Text(
                        'Daftarkan dirimu disini',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                        key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  decoration: theme().textInputDecoration('Nama', 'Masukan nama anda'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
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
                                  decoration: theme().textInputDecoration('Kata sandi', 'Masukan kata sandi'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextField(
                                  obscureText: true,
                                  decoration: theme().textInputDecoration('Konfirmasi kata sandi', 'Masukan kata sandi lagi'),
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
                                    child: Text('Daftar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: (){
                                    //After successful login we will redirect to profile page. Let's create profile page now
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage()));
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10,20,10,20),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Sudah punya akun? "),
                                      TextSpan(
                                        text: 'masuk',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
                                          },
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                                      ),
                                    ]
                                  )
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