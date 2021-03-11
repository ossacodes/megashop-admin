import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:megashopadmin/screens/view/product_view.dart';

class ListCard extends StatelessWidget {
  final String url;
  final String qty;
  final String price;
  final String sellingPrice;
  final String name;
  final String documentID;

  ListCard(
      {this.url,
      this.name,
      this.price,
      this.qty,
      this.sellingPrice,
      this.documentID});
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future calculate(int price, int quantity) async {
    FirebaseFirestore.instance
        .collection('financial')
        .doc('EKZ1MAHJUrqOB4AyKiRl')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        int invest = int.parse(documentSnapshot.data()['investment']) -
            (price * quantity);
        _firestore.collection('financial').doc('EKZ1MAHJUrqOB4AyKiRl').update({
          'investment': invest.toString(),
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Future calculate_qty(int quantity) async {
    FirebaseFirestore.instance
        .collection('financial')
        .doc('qSZRXr7Bkqw2ruuqS0MG')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        int q = int.parse(documentSnapshot.data()['total']) - quantity;
        _firestore.collection('financial').doc('qSZRXr7Bkqw2ruuqS0MG').update({
          'total': q.toString(),
        });

        int r = int.parse(documentSnapshot.data()['remaining']) - quantity;
        _firestore.collection('financial').doc('qSZRXr7Bkqw2ruuqS0MG').update({
          'remaining': r.toString(),
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Future calcRevenue(int quantity, int sPrice, int pPrice) async {
    FirebaseFirestore.instance
        .collection('financial')
        .doc('qSZRXr7Bkqw2ruuqS0MG')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        int q = int.parse(documentSnapshot.data()['sold']) + quantity;
        _firestore.collection('financial').doc('qSZRXr7Bkqw2ruuqS0MG').update({
          'sold': q.toString(),
        });

        int r = int.parse(documentSnapshot.data()['remaining']) - quantity;
        _firestore.collection('financial').doc('qSZRXr7Bkqw2ruuqS0MG').update({
          'remaining': r.toString(),
        });
      } else {
        print('Document does not exist on the database');
      }
    });
    FirebaseFirestore.instance
        .collection('financial')
        .doc('EKZ1MAHJUrqOB4AyKiRl')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        int s = int.parse(documentSnapshot.data()['revenue']) +
            (sPrice * quantity);
        _firestore.collection('financial').doc('EKZ1MAHJUrqOB4AyKiRl').update({
          'revenue': s.toString(),
        });
        int p = int.parse(documentSnapshot.data()['profit']) +
            ((sPrice - pPrice) * quantity);
        _firestore.collection('financial').doc('EKZ1MAHJUrqOB4AyKiRl').update({
          'profit': p.toString(),
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sellQuantity;
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
        leading: Container(
          width: 45.0,
          height: 45.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(url),
            ),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${sellingPrice} RWF",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          "Qty: ${qty}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        tileColor: Colors.brown[50],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductView(
                name: name,
                url: url,
                sellingPrice: sellingPrice,
                price: price,
                qty: qty,
              ),
            ),
          );
        },
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Sell',
          color: Colors.indigo,
          icon: Icons.shopping_bag,
          onTap: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Sell',
              desc: 'Are you sure you want to sell ?',
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    onChanged: (value) {
                      sellQuantity = value;
                    },
                    style: TextStyle(fontSize: 18.0),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.isEmpty ? 'Enter  Quantity !' : null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      prefixIcon: Icon(
                        Icons.shopping_bag_outlined,
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
                      hintText: 'Quantity',
                      hintStyle:
                          TextStyle(fontSize: 18.0, color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
              btnCancelOnPress: () {},
              btnOkOnPress: () async {
                if (_formKey.currentState.validate()) {
                  int totalQuantity = int.parse(qty) - int.parse(sellQuantity);
                  await calcRevenue( int.parse(sellQuantity), int.parse(sellingPrice) , int.parse(price));
                  await _firestore
                      .collection('products')
                      .doc(documentID)
                      .update({
                    'qty': totalQuantity.toString(),
                  });
                }
              },
            )..show();
          },
        ),
      ],
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
                  Reference imageRef =
                      await FirebaseStorage.instance.getReferenceFromUrl(url);

                  await imageRef.delete();
                  await calculate(int.parse(price), int.parse(qty));
                  await calculate_qty(int.parse(qty));
                  await _firestore
                      .collection('products')
                      .doc(documentID)
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
