import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Negoisasi',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NegoisasiPage(title: 'Fitur Negoisasi'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NegoisasiPage extends StatefulWidget {
  const NegoisasiPage({super.key, required this.title});

  final String title;

  @override
  State<NegoisasiPage> createState() => _NegoisasiState();
}

class _NegoisasiState extends State<NegoisasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Color.fromARGB(255, 118, 118, 118),
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 3, 134, 0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Color.fromARGB(255, 238, 238, 238)),
                              height: 150,
                              width: 150,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(40, 10, 80, 10),
                              child: Column(children: [
                                Container(
                                  child: Column(children: [
                                    SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("NAMA PRODUK",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 43, 43, 43),
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Harga",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("[Jumlah] x",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Total Harga",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ),
                                    SizedBox(height: 20),
                                  ]),
                                ),
                              ]),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
                  padding: EdgeInsets.fromLTRB(40, 10, 80, 10),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        child: Row(children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Ajukan Negoisasi",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 43, 43, 43),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          SizedBox(width: 100),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text("Status",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 73, 255, 73),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Masukan Harga Negoisasi',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Nego'),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Color.fromARGB(255, 3, 134, 0),
                            onSurface: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ]),
            ),
            SizedBox(height: 50),
            Container(
              height: 10,
              color: Color.fromARGB(255, 146, 146, 146),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("TOTAL PEMBAYARAN",
                        style: TextStyle(
                            color: Color.fromARGB(255, 82, 80, 80),
                            fontSize: 25)),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Rp 10.000.000",
                        style: TextStyle(
                          color: Color.fromARGB(255, 82, 80, 80),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
