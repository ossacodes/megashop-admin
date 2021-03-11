import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  CardData({this.text, this.quantity});
  final String text;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              quantity.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: Colors.brown
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.brown
              ),
            ),
          ],
        ),
      ),
    );
  }
}
