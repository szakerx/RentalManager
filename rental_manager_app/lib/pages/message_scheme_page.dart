import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/message_scheme.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/model/user.dart';
import 'package:rental_manager_app/pages/message_schemes_list_page.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';

class MessageSchemePage extends StatefulWidget {
  MessageScheme scheme;
  bool isInEditMode = false;
  MessageSchemesListState parent;

  MessageSchemePage(this.parent, {this.isInEditMode});

  MessageSchemePage.withData(this.parent, this.scheme);

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
    _contentController =
        TextEditingController(text: widget.scheme?.content ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Schemat wiadomości"),
          actions: [
            widget.isInEditMode
                ? Container()
                : IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        widget.isInEditMode = true;
                      });
                    })
          ],
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
                      readOnly: !widget.isInEditMode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Pole nie może być puste";
                        }
                        return null;
                      },
                      decoration: TextInputDecoration(labelText: "Nazwa")
                          .getInputDecoration(),
                    ),
                    Padding(padding: EdgeInsets.all(15.0)),
                    TextFormField(
                      controller: _contentController,
                      readOnly: !widget.isInEditMode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Pole nie może być puste";
                        }
                        return null;
                      },
                      decoration:
                          TextInputDecoration(labelText: "Treść wiadomości")
                              .getInputDecoration(),
                      maxLines: null,
                      maxLength: 255,
                      minLines: 7,
                    ),
                    Padding(padding: EdgeInsets.all(15.0)),
                    widget.isInEditMode
                        ? ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                MessageScheme scheme;
                                if (widget.scheme == null) {
                                  scheme = MessageScheme(
                                    id: -1,
                                    name: _nameController.text,
                                    content: _contentController.text,
                                    user: User(
                                        id: Firebase.FirebaseAuth.instance
                                            .currentUser.uid),
                                  );
                                } else {
                                  scheme = MessageScheme(
                                    id: widget.scheme.id,
                                    name: _nameController.text,
                                    content: _contentController.text,
                                    user: widget.scheme.user,
                                  );
                                }

                                await Remote.postMessageScheme(scheme)
                                    .then((value) {
                                  widget.parent.updateSchemes();
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Text("Zapisz"))
                        : Container(),
                  ],
                ),
              ),
            )));
  }
}
