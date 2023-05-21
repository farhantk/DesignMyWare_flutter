import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tubesflutter/providers/transaction_provider.dart';
import 'package:tubesflutter/services/transaction_service.dart';

import '../Theme/theme.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import 'landingpage.dart';
import 'track.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<String> categories = [
    'Menunggu konfirmasi',
    'Diproses',
    'Dikirim',
    'Selesai',
  ];

  String currentCategory = 'Menunggu konfirmasi';
    String convertDateFormat(String originalDate) {
    // Parsing tanggal awal
    DateTime dateTime = DateTime.parse(originalDate);
    
    // Format tanggal yang diinginkan
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    
    // Mengonversi dan mengembalikan tanggal yang diformat
    return formatter.format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    TransactionProvider transactionProvider = Provider.of<TransactionProvider>(context);
    handleFinish(int orderId) async{

      bool response = await transactionProvider.Finish(
        token: user.token!,
        orderId: orderId,
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
    Future<void> getTransactions() async {
      await transactionProvider.Showtransaction(
        id: user.id!,
        token: user.token!,
      );
    }
    
    dynamic order = transactionProvider.order;
    List<dynamic> orders = [];
    if (order != null) {
      orders = order['orders'];
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      currentCategory = categories[index];
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(8, 45, 8, 15),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: currentCategory == categories[index]
                        ? theme().buttonBoxDecoration(context,
                            fillColor: Colors.white)
                        : theme().buttonBoxDecoration(context),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: currentCategory == categories[index]
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getTransactions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: orders
                        .where((transaction) =>
                            transaction['status'] == currentCategory)
                        .length,
                    itemBuilder: (context, index) {
                      dynamic transaction = orders
                          .where((transaction) =>
                              transaction['status'] == currentCategory)
                          .toList()[index];
                      dynamic pesanan = transaction['pesanan'];
                      List<dynamic> pesananDetails =
                          pesanan['pesanan_details'];
                      if(transaction != null){
                        return Column(
                          children: [
                            Card(
                              elevation: 3,
                              margin: EdgeInsets.only(bottom: 16.0),
                              child: InkWell(
                                onTap: () {
                                  // handle track button tap
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(8, 15, 8, 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${transaction['status']} | ${convertDateFormat(transaction['created_at'])}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          for (var pesananDetail
                                              in pesananDetails)
                                            Text(
                                                '${pesananDetail['jumlah_pesanan']}x ${pesananDetail['product']['name']}',
                                            ),
                                          Text(
                                            'Rp. ${pesanan['total_price']}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (transaction['status'] == 'Dikirim')
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                primary: Theme.of(context).primaryColor,
                                                padding: EdgeInsets.all(5.0),
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/track',
                                                  arguments: {
                                                    'courierName': transaction['courier']['name'],
                                                    'receiptCode': transaction['receipt_code'],
                                                  },
                                                );
                                              },
                                              child: Text(
                                                'Lacak',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10), // Jarak antara dua tombol
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 1.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                primary: Theme.of(context).primaryColor,
                                                padding: EdgeInsets.all(5.0),
                                              ),
                                              onPressed: () => handleFinish(transaction['id']),
                                              child: Text(
                                                'Sampai',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}