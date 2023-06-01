import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/pages/signup.dart';
import 'package:tubesflutter/providers/auth_provider.dart';

import '../Theme/theme.dart';
import '../models/user_model.dart';
import 'editprofile.dart';
import 'landingpage.dart';
import 'signin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<StatefulWidget> {
  Key _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    UserModel? user = authProvider.user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('http://192.168.1.2:8000/storage/post-image/JKbIttOihjQeke1hhG8db9IPueKvN4vrrp2BZuZM.png'),
              ),
              SizedBox(height: 20),
              Text(
                '${user?.name}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${user?.email}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: theme().buttonBoxDecoration(context),
                child: ElevatedButton(
                  style: theme().buttonStyle(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: Text('Ubah Profil',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  onPressed: () {
                    //After successful login we will redirect to profile page. Let's create profile page now
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()));
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(thickness: 1),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(LineIcons.bell),
                title: Text('Notifications'),
                trailing: Icon(LineIcons.arrowLeft),
                onTap: () {
                  // TODO: Implement notifications screen
                },
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(LineIcons.cog),
                title: Text('Privacy'),
                trailing: Icon(LineIcons.arrowLeft),
                onTap: () {
                  // TODO: Implement privacy settings screen
                },
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(LineIcons.doorOpen),
                title: Text('Keluar'),
                trailing: Icon(LineIcons.arrowLeft),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
