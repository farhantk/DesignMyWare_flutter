import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tubesflutter/pages/signup.dart';

import '../Theme/theme.dart';
import 'landingpage.dart';
import 'profile.dart';

class TrackPage extends StatefulWidget{
  const TrackPage({super.key});
  @override
  State<StatefulWidget> createState() => _TrackPageState();

}

class _TrackPageState extends State<StatefulWidget>{
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
    );
  }
}