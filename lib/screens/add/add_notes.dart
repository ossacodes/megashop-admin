import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:megashopadmin/widgets/loading.dart';

class AddNotes extends StatefulWidget {
  static final String id = "add_notes";
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  String title;
  String note;
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
      ),
      body: isLoading ? Loader() : SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  cursorColor: Colors.brown,
                  onChanged: (value) {
                    title = value;
                  },
                  validator: (value) =>
                      value.isEmpty ? 'Enter Note title!' : null,
                  style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Icon(
                      Icons.title_outlined,
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
                    hintText: 'Tittle',
                    hintStyle:
                        TextStyle(fontSize: 18.0, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  cursorColor: Colors.brown,
                  onChanged: (value) {
                    note  = value;
                  },
                  validator: (value) => value.isEmpty ? 'Enter your Note!' : null,
                  style: TextStyle(fontSize: 18.0),
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Icon(
                      Icons.notes_rounded,
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
                    hintText: 'Enter your note text.',
                    hintStyle:
                        TextStyle(fontSize: 18.0, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  shape: StadiumBorder(),
                  color: Colors.brown,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      await _firestore
                          .collection('notes')
                          .document()
                          .setData(
                        {
                          'title': title,
                          'note': note,
                          'date': DateTime.now()
                        },
                      );
                      setState(() {
                        Navigator.pop(context);
                        isLoading = false;
                      });
                    }
                  },
                  child: Text(
                    "ADD",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
