import 'package:flutter/material.dart';
import 'package:megashopadmin/widgets/product_view_row.dart';

class CustomerView extends StatelessWidget {
  CustomerView({this.address, this.name, this.note, this.phone});
  final String name;
  final String address;
  final String phone;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer View"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      RowView(
                        name: "Name",
                        data: name,
                      ),
                      RowView(
                        name: "Address:",
                        data: address,
                      ),
                      RowView(
                        name: "Phone N:",
                        data: phone,
                      ),
                      RowView(
                        name: "Note:",
                        data: note,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
