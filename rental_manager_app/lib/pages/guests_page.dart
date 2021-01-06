import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/guest.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';

class GuestPage extends StatefulWidget {
  Guest guest;
  bool isInEditMode;

  GuestPage({this.guest, this.isInEditMode = false});

  @override
  State<StatefulWidget> createState() {
    return GuestPageState();
  }
}

class GuestPageState extends State<GuestPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _surnameController;
  TextEditingController _mailController;
  TextEditingController _phoneController;
  TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.guest?.person?.name ?? "");
    _surnameController =
        TextEditingController(text: widget.guest?.person?.surname ?? "");
    _mailController =
        TextEditingController(text: widget.guest?.person?.mail ?? "");
    _phoneController =
        TextEditingController(text: widget.guest?.person?.phone ?? "");
    _noteController = TextEditingController(text: widget.guest?.note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gość"),
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
            child: ListView(
              children: [
                Form(
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
                        decoration: TextInputDecoration(labelText: "Imie")
                            .getInputDecoration(),
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      TextFormField(
                        controller: _surnameController,
                        readOnly: !widget.isInEditMode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Pole nie może być puste";
                          }
                          return null;
                        },
                        decoration: TextInputDecoration(labelText: "Nazwisko")
                            .getInputDecoration(),
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      TextFormField(
                        controller: _mailController,
                        readOnly: !widget.isInEditMode,
                        validator: (value) {
                          if (value == null) {
                            return 'Pole nie może być puste';
                          } else {
                            Pattern p =
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])"
                                r"?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                            RegExp regex = new RegExp(p);
                            if (!regex.hasMatch(value)) {
                              return "Niepoprawny e-mail";
                            } else {
                              return null;
                            }
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: TextInputDecoration(labelText: "Mail")
                            .getInputDecoration(),
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      TextFormField(
                        controller: _phoneController,
                        readOnly: !widget.isInEditMode,
                        validator: (value) {
                          Pattern p = r"(^(?:[+0]9)?[0-9]{10,12}$)";
                          RegExp regex = new RegExp(p);
                          if (!regex.hasMatch(value)) {
                            return "Niepoprawny numer telefonu";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration:
                            TextInputDecoration(labelText: "Numer telefonu")
                                .getInputDecoration(),
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      TextFormField(
                        controller: _noteController,
                        readOnly: !widget.isInEditMode,
                        decoration: TextInputDecoration(labelText: "Notatki")
                            .getInputDecoration(),
                        maxLines: null,
                        maxLength: 255,
                        minLines: 7,
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      widget.isInEditMode
                          ? ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  // TODO zapisz do bazy danych
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Zapisz"))
                          : Container(),
                    ],
                  ),
                )
              ],
            )));
  }
}
