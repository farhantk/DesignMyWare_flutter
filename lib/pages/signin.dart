import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/providers/transaction_provider.dart';

import '../Theme/theme.dart';
import '../providers/auth_provider.dart';
import 'checkout.dart';
import 'landingpage.dart';
import 'profile.dart';
import 'signup.dart';


class SignInPage extends StatefulWidget{
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();

}

class _SignInPageState extends State<SignInPage>{
  Key _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    TransactionProvider transactionProvider = Provider.of<TransactionProvider>(context);
    handleSignIn() async{
      if(await authProvider.SignIn(
        email: emailController.text, 
        password: passwordController.text, 
      )& await transactionProvider.ShowExpedition()){
        print(transactionProvider.expedition);
        Navigator.pushNamed(context, '/home');
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor('#ED2B2A'),
            content: Text(
              'Gagal masuk',
              textAlign: TextAlign.center,
            ),
          )
        );
      }
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/signin_bg.png"), // ganti dengan path ke gambar latar belakang yang ingin digunakan
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SafeArea(
                child: Container( 
                  padding: EdgeInsets.fromLTRB(20, 150, 20, 280),
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
                        'Masuk dengan akunmu',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                        key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: theme().textInputDecoration('Email', 'Masukan email anda'),
                                ),
                                decoration: theme().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: theme().textInputDecoration('Kata sandi', 'Masukan kata sandi'),
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
                                    child: Text('Masuk', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: handleSignIn,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10,20,10,20),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "Belum punya akun? "),
                                      TextSpan(
                                        text: 'daftar',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
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