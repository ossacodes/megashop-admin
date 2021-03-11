import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:megashopadmin/modals/user.dart';
import 'package:megashopadmin/screens/navigate.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // user obj based on firebase
  UserData _userFromFirebaseUser(User user) {
    return user != null
        ? UserData(
            uid: user.uid,
            email: user.email,
          )
        : null;
  }

  // auth changes stream
  Stream<UserData> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // login function
  Future signIn(BuildContext context, GlobalKey<ScaffoldState> _scaffold,
      String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        User user = value.user;
        print(user.uid);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Navigate(),
          ),
        );
        return _userFromFirebaseUser(user);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _scaffold.currentState.showSnackBar(
          new SnackBar(content: new Text("No user found for that email.")),
        );
        return null;
      } else if (e.code == 'wrong-password') {
        _scaffold.currentState.showSnackBar(
          new SnackBar(content: new Text("Wrong password provided for that user.")),
        );
        return null;
      }
    }
  }

  // signout user
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
