import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/pages/landing_page.dart';
import '../widgets/sign_in_form.dart';
import 'package:rental_manager_app/model/user.dart' as model;


class SignInPage extends StatelessWidget {

  String action;
  SignInPage(this.action);

  Future<void> _registerWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      Remote.postUser(model.User(id: userCredential.user.uid));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Podane haslo jest za słabe.")));
      } else if (e.code == 'email-already-in-use') {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Konto dla podanego adresu e-mail już istnieje. Spróbuj się zalogować.")));
      }
    } catch (e) {
      print(e);
    }
  }
  Future<void> _signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Użytkownik dla podanego adresu e-mail nie istnieje. Spróbuj się zarejestrować.")));
      } else if (e.code == 'wrong-password') {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Złe hasło.")));
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
        child: ListView(
          children: [
            Center(
                child: SigningForm(buttonFunction: signingFunction(), action: action,)
            )
          ]
        )
      )
    );
  }
}