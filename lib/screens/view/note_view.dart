import 'package:flutter/material.dart';
import 'package:megashopadmin/widgets/product_view_row.dart';

class NoteView extends StatelessWidget {
  final String title;
  final String note;
  NoteView({this.note, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("Note View"),
     ),
     body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      RowView(name: "Title", data: title,),
                      RowView(name: "Note:", data: note,),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}