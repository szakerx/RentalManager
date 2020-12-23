

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/message_scheme.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';

class MessageSchemePage extends StatefulWidget {

  MessageScheme scheme;

  MessageSchemePage();
  MessageSchemePage.withData(this.scheme);

  @override
  State<StatefulWidget> createState() {
    return MessageSchemePageState();
  }
}

class MessageSchemePageState extends State<MessageSchemePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.scheme?.name ?? "");
    _contentController = TextEditingController(text: widget.scheme?.content ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Schemat wiadomości"),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(15.0)),

                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Pole nie może być puste";
                      }
                      return null;
                    },
                    decoration: TextInputDecoration(labelText: "Nazwa").getInputDecoration(),
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  TextFormField(
                    controller: _contentController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Pole nie może być puste";
                      }
                      return null;
                    },
                    decoration: TextInputDecoration(labelText: "Treść wiadomości").getInputDecoration(),
                    maxLines: null,
                    maxLength: 255,
                    minLines: 7,
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // TODO zapisz do bazy danych
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Zapisz")),
                ],
              ),
            ),
          )
        )
    );
  }
}