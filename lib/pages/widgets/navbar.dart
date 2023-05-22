// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:tubesflutter/pages/homepage.dart';
// import 'package:tubesflutter/pages/profile.dart';
// import 'package:tubesflutter/pages/transaction.dart';

// // void main() => runApp(NavBar());

// class NavBar extends StatefulWidget {
//   // final String user_img;
//   @override
//   _NavBarState createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   int _currentIndex = 0;
//   final List<Widget> _children = [
//     HomePage(),
//     HomePage(),
//     TransactionPage(),
//     ProfilePage(),
//   ];

//   void onTappedBar(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route
//       onWillPop: () async {
//         return Future.value(
//             false); //return a `Future` with false value so this route cant be popped or closed.
//       },
//       child: Scaffold(
//         body: _children[_currentIndex],
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColor,
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 20,
//                 color: Colors.black.withOpacity(.1),
//               )
//             ],
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//               child: GNav(
//                   rippleColor: Colors.grey[300]!,
//                   hoverColor: Colors.grey[100]!,
//                   gap: 8,
//                   activeColor: Colors.white,
//                   iconSize: 24,
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                   duration: Duration(milliseconds: 400),
//                   tabBackgroundColor: HexColor('#6dc859'),
//                   color: Colors.white,
//                   tabs: [
//                     GButton(
//                       icon: LineIcons.home,
//                       text: 'Beranda',
//                     ),
//                     GButton(
//                       icon: LineIcons.heart,
//                       text: 'Likes',
//                     ),
//                     GButton(
//                       icon: LineIcons.creditCard,
//                       text: 'Transaksi',
//                     ),
//                     GButton(
//                       icon: LineIcons.user,
//                       text: 'Profil',
//                     ),
//                   ],
//                   selectedIndex: _currentIndex,
//                   onTabChange: onTappedBar),
//             ),
//           ),
//         ),
//         // bottomNavigationBar: buildCustomNavigationBar(),
//       ),
//     );
//   }

//   BottomNavigationBar buildCustomNavigationBar() {
//     return BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: onTappedBar,
//         items: [
//           BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Beranda'),
//           BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Beranda'),
//           BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Beranda'),
//           BottomNavigationBarItem(icon: Icon(LineIcons.home), label: 'Beranda'),
//         ]);
//   }
// }
