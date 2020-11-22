import 'package:flutter/material.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';
import '../pages/sign_in.dart';

class SigningForm extends StatefulWidget {
  Function buttonFunction;
  String currentAction;
  String nextAction;
  String buttonText;
  String titleText;
  String redirectText;
  String redirectButtonText;

  SigningForm({this.buttonFunction, action}) {
    this.buttonFunction = buttonFunction;
    this.currentAction = action;

    switch (currentAction) {
      case "login":
        this.nextAction = "register";
        this.buttonText = "Zaloguj";
        this.titleText = "Logowanie";
        this.redirectText = "Nie masz konta?";
        this.redirectButtonText = "Zarejestruj się";
        break;
      case "register":
        this.nextAction = "login";
        this.buttonText = "Zarejestruj";
        this.titleText = "Rejestracja";
        this.redirectText = "Masz już konto?";
        this.redirectButtonText = "Zaloguj się";
        break;
      default:
        print("DUPA BLADA");
    }
  }

  @override
  SigningFormState createState() {
    return SigningFormState();
  }
}

class SigningFormState extends State<SigningForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void navigateToSigningPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage(widget.nextAction)));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
                children: <Widget>[
                  Text(widget.titleText),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Pole nie może być puste";
                      }
                      return null;
                    },
                    decoration: TextInputDecoration(labelText: "E-mail").getInputDecoration(),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Pole nie może być puste";
                      }
                      return null;
                    },
                    decoration: TextInputDecoration(labelText: "Hasło").getInputDecoration(),
                    obscureText: true,
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          widget.buttonFunction(emailController.text, passwordController.text, context);
                        }
                      },
                      child: Text(widget.buttonText)),
                  Padding(padding: EdgeInsets.only(top: 30.0)),
                  Text(widget.redirectText),
                  TextButton(onPressed: navigateToSigningPage, child: Text(widget.redirectButtonText))
                ]
            )
          );
  }
}