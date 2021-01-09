import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/model/rental_object.dart';
import 'package:rental_manager_app/model/user.dart';
import 'package:rental_manager_app/pages/rental_objects_list_page.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';

class RentalObjectsPage extends StatefulWidget {
  RentalObject rentalObject;
  bool isInEditMode;
  RentalObjectsListState parent;

  RentalObjectsPage(this.parent, {this.rentalObject, this.isInEditMode = false});

  @override
  State<StatefulWidget> createState() {
    return RentalObjectsPageState();
  }
}

class RentalObjectsPageState extends State<RentalObjectsPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _maxGuestsController;

  bool _animalsAllowed = false;
  bool _validated = true;

  Map<String, String> _rentalObjectTypes = {
    "ROOM": "Pokój",
    "HOUSE": "Dom",
    "APARTMENT": "Apartament"
  };
  String _selectedRentalObjectType;
  List<String> _rentalObjectTypesString = ["Pokój", "Dom", "Apartament"];

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.rentalObject?.name ?? "");
    _descriptionController =
        TextEditingController(text: widget.rentalObject?.description ?? "");
    _maxGuestsController = TextEditingController(text: widget.rentalObject?.maxGuests?.toString() ?? "1");
    if (widget.rentalObject != null) {
      _selectedRentalObjectType = _rentalObjectTypes[widget.rentalObject?.type];
      _animalsAllowed = widget.rentalObject.allowedAnimals;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Obiekt"),
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
                      decoration: TextInputDecoration(labelText: "Nazwa")
                          .getInputDecoration(),
                    ),
                    Padding(padding: EdgeInsets.all(15.0)),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          Flexible(
                              child: DropdownButtonFormField(
                                  hint: Text("Wybierz rodzaj obiektu"),
                                  value: _selectedRentalObjectType,
                                  items:
                                      _rentalObjectTypesString.map((element) {
                                    return DropdownMenuItem(
                                      child: new Text(element),
                                      value: element,
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _validated = true;
                                      _selectedRentalObjectType = newValue;
                                    });
                                  })),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Text("Zwierzęta"),
                          Switch(
                              value: _animalsAllowed,
                              onChanged: (value) {
                                setState(() {
                                  _animalsAllowed = value;
                                });
                              })
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(15.0)),
                    TextFormField(
                      controller: _maxGuestsController,
                      validator: (value) {
                        if (int.parse(value) < 1) {
                          return "Wartość nie może być mniejsza od 1";
                        }
                        return null;
                      },
                      readOnly: !widget.isInEditMode,
                      decoration: TextInputDecoration(
                              labelText: "Maksymalna ilość gości")
                          .getInputDecoration(),
                      keyboardType: TextInputType.number,
                    ),
                    Padding(padding: EdgeInsets.all(15.0)),
                    TextFormField(
                      controller: _descriptionController,
                      readOnly: !widget.isInEditMode,
                      decoration: TextInputDecoration(labelText: "Opis")
                          .getInputDecoration(),
                      maxLines: null,
                      maxLength: 255,
                      minLines: 7,
                    ),
                    widget.isInEditMode
                        ? ElevatedButton(
                            onPressed: () async {
                              if (_selectedRentalObjectType == null) {
                                setState(() {
                                  _validated = false;
                                });
                              } else {
                                if (_formKey.currentState.validate()) {
                                  RentalObject object;
                                  if (widget.rentalObject == null) {
                                    object = RentalObject(
                                        id: -1,
                                        maxGuests: int.parse(
                                            _maxGuestsController.text),
                                        description:
                                            _descriptionController.text,
                                        name: _nameController.text,
                                        type: _rentalObjectTypes.entries
                                            .where((element) =>
                                                element.value ==
                                                _selectedRentalObjectType)
                                            .first
                                            .key,
                                        allowedAnimals: _animalsAllowed,
                                        user: User(
                                            id: Firebase.FirebaseAuth.instance
                                                .currentUser.uid));
                                  } else {
                                    print(int.parse(_maxGuestsController.text));
                                    object = RentalObject(
                                      id: widget.rentalObject.id,
                                      maxGuests:
                                          int.parse(_maxGuestsController.text),
                                      description: _descriptionController.text,
                                      name: _nameController.text,
                                      type: _rentalObjectTypes.entries
                                          .where((element) =>
                                              element.value ==
                                              _selectedRentalObjectType)
                                          .first
                                          .key,
                                      allowedAnimals: _animalsAllowed,
                                      user: widget.rentalObject.user,
                                    );
                                  }

                                  await Remote.postRentalObject(object).then((value) {
                                    print("popping");
                                    print(value);
                                    widget.parent.updateList();
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            },
                            child: Text("Zapisz"))
                        : Container(),
                    Padding(padding: EdgeInsets.all(10.0)),
                    _validated
                        ? Container()
                        : Text(
                            "Wybierz rodzaj obiektu!",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    color: Theme.of(context).errorColor,
                                    fontSize: 12.0),
                          )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
