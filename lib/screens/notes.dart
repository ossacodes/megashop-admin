import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:megashopadmin/widgets/note_tile.dart';

import 'add/add_notes.dart';

class NotesPage extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: ListView(
        children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('notes').orderBy('date', descending: true).snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                // ignore: deprecated_member_use
                final notes = snapshot.data.documents;
                List<Widget> noteWidgets = [];
                for (var note in notes) {
                  final title = note['title'];
                  final note_body = note['note'];
                  final userWidget = NoteTile(
                    title: title,
                    note: note_body,
                    documentID: note.documentID,
                  );
                  noteWidgets.add(userWidget);
                }
                return noteWidgets.isNotEmpty
                    ? Column(
                        children: noteWidgets,
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
                                          'No Notes',
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown[200]
                                          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNotes.id);
        },
        backgroundColor: Colors.brown,
        child: Icon(Icons.add),
      ),
    );
  }
}
