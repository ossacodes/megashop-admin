import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:megashopadmin/screens/view/customer_view.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerTile extends StatefulWidget {
  final String name;
  final String address;
  final String phone;
  final String note;
  final String documentID;
  CustomerTile(
      {this.address, this.name, this.note, this.phone, this.documentID});

  @override
  _CustomerTileState createState() => _CustomerTileState();
}

class _CustomerTileState extends State<CustomerTile> {
  final _firestore = FirebaseFirestore.instance;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
            Icons.account_circle,
            size: 45.0,
          ),
        ),
        title: Text(
          widget.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.note,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        tileColor: Colors.brown[50],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CustomerView(
                name: widget.name,
                address: widget.address,
                note: widget.note,
                phone: widget.phone,
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Call',
          color: Colors.indigo,
          icon: Icons.call,
          onTap: () async {
           await _makePhoneCall('tel:${widget.phone}');
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {
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
                      .collection('customers')
                      .document(widget.documentID)
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
