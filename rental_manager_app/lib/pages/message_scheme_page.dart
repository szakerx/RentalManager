

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/message_scheme.dart';

class MessageSchemePage extends StatelessWidget {
  MessageScheme scheme;

  MessageSchemePage();
  MessageSchemePage.withData(this.scheme);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schemat wiadomości"),
        actions: [
          FlatButton(
            child: Icon(Icons.save),
            onPressed: () {
              //TODO Call do api
              print(scheme.name);
              print("Zapisz na serwerze");
            },
          ),
        ],
      ),
      body: Container(
        child: Text("DUPA"),
      )
    );
  }

}