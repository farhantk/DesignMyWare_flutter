import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
    'Category 1': ['Transaction 1', 'Transaction 2', 'Transaction 3'],
    'Category 2': ['Transaction 4', 'Transaction 5', 'Transaction 6'],
    'Category 3': ['Transaction 7', 'Transaction 8', 'Transaction 9'],
    'Category 4': ['Transaction 10', 'Transaction 11', 'Transaction 12'],
  };

  String currentCategory = 'Category 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 60,
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
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: currentCategory == categories[index]
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: Colors.white,
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
                      child: InkWell(
                        onTap: () {
                          // handle track button tap
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(transactions[currentCategory]![index]),
                              ElevatedButton(
                                onPressed: () {
                                  // handle track button tap
                                },
                                child: Text('Track'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
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