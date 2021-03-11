import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:megashopadmin/screens/customers.dart';
import 'package:megashopadmin/screens/products.dart';
import 'package:megashopadmin/services/auth.dart';
import 'package:megashopadmin/widgets/card_data_widget.dart';
import 'package:megashopadmin/widgets/financial_data_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String investment;

  String reveneu;

  String profit;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    dynamic convertFigure(String amount) {
      var total;
      double number;
      if (amount != '0') {
        if (amount.split('').length > 8) {
          total = int.parse(amount) / 1000000000;
          number = total;
          number.toStringAsPrecision(2);
          return '${number.toStringAsPrecision(4)} K';
        } else if (amount.split('').length > 6) {
          total = int.parse(amount) / 1000000;
          number = total;
          number.toStringAsPrecision(2);
          return '${number.toStringAsPrecision(4)} M';
        } else if (amount.split('').length > 4) {
          total = int.parse(amount) / 1000;
          number = total;
          number.toStringAsPrecision(2);
          return '${number.toStringAsPrecision(4)} K';
        } else {
          return amount;
        }
      } else {
        return '0';
      }
    }

    CollectionReference financial =
        FirebaseFirestore.instance.collection('financial');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.short_text_rounded,
            size: 40,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Text("Stock Management"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () {
              AuthServices().signOut();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Text('Menu'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: StreamBuilder(
                      stream: financial.doc('EKZ1MAHJUrqOB4AyKiRl').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        var document = snapshot.data;
                        return Row(
                          children: [
                            FinancialCard(
                              quantity: convertFigure(document['investment']),
                              text: "Investment",
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                color: Colors.brown[100],
                                width: 2,
                                height: 100.0,
                              ),
                            ),
                            FinancialCard(
                              quantity: convertFigure(document['revenue']),
                              text: "Revenue",
                            ),
                            Expanded(
                              flex: 0,
                              child: Container(
                                color: Colors.brown[100],
                                width: 2,
                                height: 100.0,
                              ),
                            ),
                            FinancialCard(
                              quantity: convertFigure(document['profit']),
                              text: "Profit",
                            ),
                          ],
                        );
                      })),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: StreamBuilder(
                    stream: financial.doc('qSZRXr7Bkqw2ruuqS0MG').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      var document = snapshot.data;
                      return Row(
                        children: [
                          CardData(
                            quantity: int.parse(document['total']),
                            text: "Total",
                          ),
                          Expanded(
                            flex: 0,
                            child: Container(
                              color: Colors.brown[100],
                              width: 2,
                              height: 100.0,
                            ),
                          ),
                          CardData(
                            quantity: int.parse(document['sold']),
                            text: "Sold",
                          ),
                          Expanded(
                            flex: 0,
                            child: Container(
                              color: Colors.brown[100],
                              width: 2,
                              height: 100.0,
                            ),
                          ),
                          CardData(
                            quantity: int.parse(document['remaining']),
                            text: "Remaining",
                          )
                        ],
                      );
                    }),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: GridView(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ProductsPage.id);
                    },
                    child: Card(
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment,
                              size: 80.0, color: Colors.brown),
                          Text(
                            "PRODUCTS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.brown),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, CustomersPage.id),
                    child: Card(
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group, size: 80.0, color: Colors.brown),
                          Text(
                            "CUSTOMERS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.brown),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
