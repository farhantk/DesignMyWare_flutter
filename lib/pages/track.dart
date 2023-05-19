import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/pages/signup.dart';

import '../Theme/theme.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';
import 'landingpage.dart';
import 'profile.dart';

class TrackPage extends StatefulWidget{
  final String courierName;
  final String receipt_code;
  TrackPage({super.key, required this.courierName, required this.receipt_code});
  //const TrackPage({super.key});
  @override
  State<StatefulWidget> createState() => _TrackPageState();

}

class _TrackPageState extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String courierName = arguments['courierName'];
    String receiptCode = arguments['receiptCode'];

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    TransactionProvider transactionProvider = Provider.of<TransactionProvider>(context);
 
    Future<dynamic> trackData = transactionProvider.Track(courierName: 'courierName', receipt_code: 'receiptCode', token: 'user.token');

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