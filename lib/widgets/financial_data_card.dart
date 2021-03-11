import 'package:flutter/material.dart';

class FinancialCard extends StatelessWidget {
  FinancialCard({this.text, this.quantity});
  final String text;
  final String quantity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              quantity,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Colors.brown),
            ),
            Text(
              'RWF',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.brown),
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }
}
