import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:megashopadmin/widgets/customer_tile.dart';

import 'add/add_customer.dart';

class CustomersPage extends StatelessWidget {
  static final String id = "customers_page";
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Customers"),
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('customers')
                .orderBy('date', descending: true)
                .snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SizedBox();
              }
              // ignore: deprecated_member_use
              final customers = snapshot.data.documents;
              List<Widget> customerWidgets = [];
              for (var customer in customers) {
                final name = customer['name'];
                final note_body = customer['note'];
                final address = customer['address'];
                final phone = customer['phone'];
                final customerWidget = CustomerTile(
                  name: name,
                  address: address,
                  note: note_body,
                  phone: phone,
                  documentID: customer.documentID,
                );
                customerWidgets.add(customerWidget);
              }
              return customerWidgets.isNotEmpty
                  ? Column(
                      children: customerWidgets,
                    )
                  : Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Center(
                                      child: Text(
                                        'No Customers',
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown[200]),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddCustomer.id);
        },
        backgroundColor: Colors.brown,
        child: Icon(Icons.add),
      ),
    );
  }
}
