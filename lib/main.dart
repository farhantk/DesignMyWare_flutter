import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/pages/cart_list.dart';
import 'package:tubesflutter/pages/editprofile.dart';
import 'package:tubesflutter/pages/landingpage.dart';
import 'package:tubesflutter/pages/signup.dart';
import 'package:tubesflutter/providers/auth_provider.dart';
import 'package:tubesflutter/providers/cart_provider.dart';

import 'pages/signin.dart';
import 'pages/splash_screen.dart';
import 'pages/track.dart';
import 'providers/transaction_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color primary_color = HexColor('#42B549');
  Color accent_color = HexColor('#1b711a');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          '/': (context) => SplashScreen(),
          '/signin': (context) => SignInPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => LandingPage(),
          '/editprofile': (context) => EditProfilePage(),
          '/cart': (context) => CartPage(),
          '/track': (context) => TrackPage(
                courierName: '',
                receipt_code: '',
              ),
        },
        theme: ThemeData(
          primaryColor: primary_color,
          accentColor: accent_color,
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
