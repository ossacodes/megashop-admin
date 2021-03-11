import 'package:flutter/material.dart';
import 'package:megashopadmin/config/loader.dart';
import 'package:megashopadmin/config/palette.dart';
import 'package:megashopadmin/services/auth.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  bool load = false;
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      backgroundColor: Palette.appColor,
      body: load
          ? Loader()
          : Container(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "MegaShop.",
                          style: TextStyle(
                            color: Palette.buttonColor,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      cursorColor: Palette.appColor,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      obscureText: true,
                      cursorColor: Palette.appColor,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  FlatButton(
                    color: Palette.buttonColor,
                    onPressed: () async {
                      setState(() {
                        load = true;
                      });
                      await AuthServices()
                          .signIn(context, _scaffold, email, password);
                      setState(() {
                        load = false;
                      });
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
