import 'package:flutter/material.dart';
import 'package:megashopadmin/auth/login.dart';
import 'package:megashopadmin/modals/user.dart';
import 'package:megashopadmin/screens/navigate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user  = Provider.of<UserData>(context);
    return user == null ? Login() : Navigate();
  }
}