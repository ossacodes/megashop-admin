import 'package:flutter/material.dart';

class RowView extends StatelessWidget {
  final String name;
  final String data;
  RowView({this.name, this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Row(
          children: [
            SizedBox(
              width: 15.0,
            ),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                data,
                style: TextStyle(
                  fontSize: 17.0,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                 textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
