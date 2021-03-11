import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:megashopadmin/config/palette.dart';
import 'package:megashopadmin/widgets/loading.dart';

final _firestore = FirebaseFirestore.instance;

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final TextEditingController controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PickedFile image;
  String name;
  String qty;
  String p_price;
  String s_price;
  String description;
  bool isLoading = false;

  Future getImageFromGallery() async {
    var tempImage = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 10);

    setState(() {
      image = tempImage;
    });
  }

  Future calculate(int price, int quantity) async {
    FirebaseFirestore.instance
        .collection('financial')
        .doc('EKZ1MAHJUrqOB4AyKiRl')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        int invest = (price * quantity) +
            int.parse(documentSnapshot.data()['investment']);
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
        int q = quantity + int.parse(documentSnapshot.data()['total']);
        _firestore.collection('financial').doc('qSZRXr7Bkqw2ruuqS0MG').update({
          'total': q.toString(),
        });

        int r = quantity + int.parse(documentSnapshot.data()['remaining']);
        _firestore.collection('financial').doc('qSZRXr7Bkqw2ruuqS0MG').update({
          'remaining': r.toString(),
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Future getImageFromCamera() async {
    var tempImage = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 10);

    setState(() {
      image = tempImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    void showOption() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 180.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Container(
                      height: 4.0,
                      width: 50.0,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: FlatButton(
                      onPressed: () async {
                        try {
                          await getImageFromCamera();
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.yellow[200],
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black45,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              'Camera',
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () async {
                        try {
                          await getImageFromGallery();
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.red[200],
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: Icon(
                                Icons.image,
                                color: Colors.black45,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(width: 20.0),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Add Products"),
        ),
        body: isLoading
            ? Loader()
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InkWell(
                          onTap: () {
                            showOption();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 70.0,
                              vertical: 12.0,
                            ),
                            height: MediaQuery.of(context).size.width * 0.5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 8,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: image != null
                                  ? Image(image: FileImage(File(image.path)))
                                  : Icon(
                                      Icons.image,
                                      size: 150.0,
                                      color: Palette.appColor,
                                    ),
                            ),
                          ),
                        ),
                        TextFormField(
                          cursorColor: Colors.brown,
                          onChanged: (value) {
                            name = value;
                          },
                          style: TextStyle(fontSize: 18.0),
                          validator: (value) =>
                              value.isEmpty ? 'Enter an Product Name!' : null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            prefixIcon: Icon(
                              Icons.assignment_ind,
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
                            hintText: 'Product Name',
                            hintStyle: TextStyle(
                                fontSize: 18.0, color: Colors.grey[600]),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          cursorColor: Colors.brown,
                          onChanged: (value) {
                            qty = value;
                          },
                          style: TextStyle(fontSize: 18.0),
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? 'Enter an Quantity!' : null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            prefixIcon: Icon(
                              Icons.assistant,
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
                            hintStyle: TextStyle(
                                fontSize: 18.0, color: Colors.grey[600]),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          cursorColor: Colors.brown,
                          onChanged: (value) {
                            p_price = value;
                          },
                          style: TextStyle(fontSize: 18.0),
                          keyboardType: TextInputType.number,
                          validator: (value) => value.isEmpty
                              ? 'Enter an Purchasing Price!'
                              : null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            prefixIcon: Icon(
                              Icons.money,
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
                            hintText: 'Purchasing Price',
                            hintStyle: TextStyle(
                                fontSize: 18.0, color: Colors.grey[600]),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          cursorColor: Colors.brown,
                          onChanged: (value) {
                            s_price = value;
                          },
                          style: TextStyle(fontSize: 18.0),
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              value.isEmpty ? 'Enter an Selling Price!' : null,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            prefixIcon: Icon(
                              Icons.money,
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
                            hintText: 'Selling Price',
                            hintStyle: TextStyle(
                                fontSize: 18.0, color: Colors.grey[600]),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            description = value;
                          },
                          minLines:
                              6, // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          validator: (value) => value.isEmpty
                              ? 'Enter the product description !'
                              : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[300],
                            hintText: 'Product descrption',
                            hintStyle: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey[600],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                          shape: StadiumBorder(),
                          color: Palette.buttonColor,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (image != null) {
                                setState(() {
                                  isLoading = true;
                                });
                                List<String> splitList = name.split(" ");
                                List<String> indexList = [];

                                for (int i = 0; i < splitList.length; i++) {
                                  for (var y = 0;
                                      y < splitList[i].length;
                                      y++) {
                                    indexList.add(
                                      splitList[i]
                                          .substring(0, y)
                                          .toLowerCase(),
                                    );
                                  }
                                }
                                if (image != null) {
                                  String fileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  final firebase_storage.Reference
                                      fireStorageRef = FirebaseStorage.instance
                                          .ref()
                                          .child("products")
                                          .child(fileName);
                                  await fireStorageRef
                                      .putFile(File(image.path));
                                  final url =
                                      await fireStorageRef.getDownloadURL();
                                  await calculate(
                                      int.parse(p_price), int.parse(qty));
                                  await calculate_qty(int.parse(qty));
                                  await _firestore
                                      .collection('products')
                                      .doc()
                                      .set(
                                    {
                                      'url': url,
                                      'name': name,
                                      'p_price': p_price,
                                      's_price': s_price,
                                      'qty': qty,
                                      'description': description,
                                      'search_index': indexList,
                                      'date': DateTime.now()
                                    },
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Successfully added."),
                                  ));
                                }
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Product image required !."),
                                ));
                              }
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
              ));
  }
}

class Reference {}
