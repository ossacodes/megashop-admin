import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:megashopadmin/config/palette.dart';
import 'package:megashopadmin/screens/products.dart';

import 'add/add_products.dart';
import 'customers.dart';
import 'home.dart';
import 'notes.dart';

class Navigate extends StatefulWidget {
  Navigate({Key key}) : super(key: key);

  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  int currentTab = 0;
  List tabs = [
    Home(),
    ProductsPage(),
    AddProducts(),
    NotesPage(),
    CustomersPage()
  ];
  bool shouldPop = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        body: tabs[currentTab],
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Palette.appColor,
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.assignment, title: 'Products'),
            TabItem(icon: Icons.add, title: 'Add'),
            TabItem(icon: Icons.note_rounded, title: 'Notes'),
            TabItem(icon: Icons.people, title: 'Customers'),
          ],
          initialActiveIndex: currentTab, //optional, default as 0
          onTap: (index) {
            setState(() {
              currentTab = index;
            });
          },
        ),
      ),
    );
  }
}
