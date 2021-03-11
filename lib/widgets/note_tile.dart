import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:megashopadmin/screens/view/note_view.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String note;
  final String documentID;
  NoteTile({this.note, this.title, this.documentID});
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
        leading: Container(
          width: 45.0,
          height: 45.0,
          child: Icon(
            Icons.notes_outlined,
            size: 40.0,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(right: 170),
          child: Text(
            note,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        tileColor: Colors.brown[50],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NoteView(
                title: title,
                note: note,
              ),
            ),
          );
        },
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Delete',
              desc: 'Are you sure you want to Delete ?',
              btnCancelOnPress: () {},
              btnOkOnPress: () async {
                try {
                  await _firestore
                      .collection('notes')
                      .document(documentID)
                      .delete();
                } catch (e) {}
              },
            )..show();
          },
        ),
      ],
    );
  }
}
