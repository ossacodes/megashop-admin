import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:megashopadmin/widgets/list_tile.dart';

class ProductsPage extends StatefulWidget {
  static final String id = "products_page";

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _firestore = Firestore.instance;
  String searchString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.1,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              style: TextStyle(fontSize: 18.0),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black45,
                  size: 20.0,
                ),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    )),
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: (searchString == null || searchString.trim() == "")
                  ? _firestore.collection('products').orderBy('date', descending: true).snapshots() 
                  : _firestore
                      .collection('products')
                      .where('search_index', arrayContains: searchString)
                      .snapshots(),
                  
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                // ignore: deprecated_member_use
                final products = snapshot.data.documents;
                List<Widget> userWidgets = [];
                for (var product in products) {
                  final name = product['name'];
                  // ignore: non_constant_identifier_names
                  final p_price = product['p_price'];
                  // ignore: non_constant_identifier_names
                  final s_price = product['s_price'];
                  final qty = product['qty'];
                  final url = product['url'];
                  final userWidget = ListCard(
                    url: url,
                    name: name,
                    price: p_price,
                    sellingPrice: s_price,
                    qty: qty,
                    documentID: product.documentID,
                  );
                  userWidgets.add(userWidget);
                }
                return userWidgets.isNotEmpty
                    ? Column(
                        children: userWidgets,
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
                                          'No Products',
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
              })
        ],
      ),
    );
  }
}
