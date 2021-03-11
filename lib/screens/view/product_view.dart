import 'package:flutter/material.dart';
import 'package:megashopadmin/widgets/product_view_row.dart';

class ProductView extends StatelessWidget {
  final String url;
  final String qty;
  final String price;
  final String sellingPrice;
  final String name;

  ProductView({this.url, this.name, this.price, this.qty, this.sellingPrice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Product View"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Image(
                  image: NetworkImage(url),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      RowView(
                        name: "Name",
                        data: name,
                      ),
                      RowView(
                        name: "Qty:",
                        data: qty,
                      ),
                      RowView(
                        name: "P-Price:",
                        data: "${price} RWF",
                      ),
                      RowView(
                        name: "S-Price",
                        data: "${sellingPrice} RWF",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
