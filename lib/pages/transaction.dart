import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Theme/theme.dart';
import 'landingpage.dart';
import 'track.dart';

class TransactionPage extends StatefulWidget{
  const TransactionPage({super.key});
  @override
  State<StatefulWidget> createState() => _TransactionPageState();

}


class _TransactionPageState extends State<StatefulWidget>{
  List<String> categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
  ];

  Map<String, List<String>> transactions = {
    'Category 1': ['Transaction 1', 'Transaction 2', 'Transaction 3', 'Transaction 34', 'Transaction 33', 'Transaction 35'],
    'Category 2': ['Transaction 4', 'Transaction 5', 'Transaction 6'],
    'Category 3': ['Transaction 7', 'Transaction 8', 'Transaction 9'],
    'Category 4': ['Transaction 10', 'Transaction 11', 'Transaction 12'],
  };

  String currentCategory = 'Category 1';

  @override
  Widget build(BuildContext context) {
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
                      ? theme().buttonBoxDecoration(context, fillColor: Colors.white)
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
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: transactions[currentCategory]!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      elevation: 3, // Set elevation to 0 to remove the default Card shadow
                      margin: EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () {
                          // handle track button tap
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(transactions[currentCategory]![index],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20, 
                                      fontWeight: FontWeight.w500,
                                    )
                                  ),
                                  Text('5x Kaos'),
                                  Text('5x Kemeja'),
                                  Text('5x jaket'),
                                  Text('5x tumbler'),
                                ]
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Rp. 10000000'),
                                  SizedBox(height: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 0),
                                    decoration: theme().buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                      style: theme().buttonStyle(),
                                      child: Text(
                                        'Lacak',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15, 
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TrackPage()));
                                      },
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
              },
            ),
          ),

        ],
      ),
    );
  }
}