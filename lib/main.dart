import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color primary_color = HexColor('#42B549');
  Color accent_color = HexColor('#1b711a');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primary_color,
        accentColor: accent_color,


        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(title: 'Flutter Demo Home Page'),
    );
  }
}