import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:megashopadmin/widgets/loading.dart';

class AddCustomer extends StatefulWidget {
  static final String id = "add_customer";

  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  String name;
  String address;
  String phone;
  String note;
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
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
                    name = value;
                  },
                  style: TextStyle(fontSize: 18.0),
                  validator: (value) =>
                      value.isEmpty ? 'Enter customer name!' : null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Icon(
                      Icons.account_circle_sharp,
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
                    hintText: 'Name',
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
                    address = value;
                  },
                  style: TextStyle(fontSize: 18.0),
                  validator: (value) =>
                      value.isEmpty ? 'Enter customer address!' : null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Icon(
                      Icons.location_city,
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
                    hintText: 'Address',
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
                    phone = value;
                  },
                  style: TextStyle(fontSize: 18.0),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value.isEmpty ? 'Enter customer phone number!' : null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: Icon(
                      Icons.phone,
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
                    hintText: 'Phone',
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
                    note = value;
                  },
                  style: TextStyle(fontSize: 18.0),
                  maxLines: 2,
                  validator: (value) => value.isEmpty ? 'Enter Note!' : null,
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
                    hintText: 'Note.',
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
                      await _firestore.collection('customers').doc().set(
                        {
                          'name': name,
                          'address': address,
                          'phone': phone,
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
