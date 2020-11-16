import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {

  String action;
  SignInPage(this.action);

  Future<void> _registerWithEmailAndPassword(String email, String password) async {
    try {
      print("registering");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }
  Future<void> _signInWithEmailAndPassword(String email, String password) async {
    try {
      print("logging in");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Function signingFunction() {
    if (this.action == "login") {
      return _signInWithEmailAndPassword;
    } else {
      return _registerWithEmailAndPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rental Manager')),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Center(
          child: SigningForm(buttonFunction: signingFunction(), action: action,)
        )
      )
    );
  }
}