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

class _TrackPageState extends State<TrackPage> {
  
  

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String courierName = arguments['courierName'];
    String receiptCode = arguments['receiptCode'];

    Future<void> getTrack() async {
      AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
      UserModel user = authProvider.user;
      TransactionProvider transactionProvider =
          Provider.of<TransactionProvider>(context, listen: false);

      await transactionProvider.Track(
        courierName: courierName,
        receipt_code: receiptCode,
        token: user.token ?? '',
      );
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black45),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          },
        ),
      ),
      body: FutureBuilder(
        future: getTrack(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan saat mengambil data pelacakan.'),
            );
          } else {
            dynamic track = Provider.of<TransactionProvider>(context).track;
            if (track != null && track.containsKey('data')) {
              List<dynamic> tracks = track['data']['history']; // Inisialisasi variabel tracks
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      '${track['data']['summary']['courier']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${track['data']['summary']['awb']}',
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tracks.length,
                      itemBuilder: (context, index) {
                        dynamic historyEntry = tracks[index];
                        String date = historyEntry['date'];
                        String desc = historyEntry['desc'];

                        return ListTile(
                          title: Text(date),
                          subtitle: Text(desc),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('Tidak ada informasi pelacakan yang tersedia.'),
              );
            }
          }
        },
      ),
    );
  }
}