import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/message_scheme.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';

import 'custom_colors.dart';

class FiltersMenuDrawer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FiltersMenuDrawerState();
  }
}

class FiltersMenuDrawerState extends State<FiltersMenuDrawer> {
  String _checkedRentalObject;
  Future<List<MessageScheme>> _reservations;
  GlobalKey<FormFieldState> _dateInputKey = GlobalKey();
  TextEditingController _dateController = TextEditingController();

  final _today = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}";
      });
  }

  @override
  void initState() {
    super.initState();
    _reservations = Remote.getMessageSchemes().then((value) {
      _checkedRentalObject = value.first.id;
      return value;
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text('Filtrowanie',
                    style: Theme.of(context).textTheme.headline1.copyWith(color: CustomColors.darkBlack),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 200.0,
                    child: ListView(
                      children: [
                        FutureBuilder<List<MessageScheme>>(
                            future: _reservations,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ExpansionTile(
                                  title: Text("Obiekty"),
                                  children:
                                      () {
                                    List<Widget> tiles = List();
                                    for (var i = 0; i < snapshot.data.length; i++) {
                                      Widget tile = RadioListTile(
                                          title: Text(snapshot.data[i].name),
                                          value: snapshot.data[i].id,
                                          groupValue: _checkedRentalObject,
                                          onChanged: (value) {
                                            setState(() {
                                              _checkedRentalObject = value;
                                            });
                                          });
                                      tiles.add(tile);
                                    }
                                    return tiles;
                                  }()
                                  ,
                                );
                              } else if (snapshot.hasError) {
                                return Text("Wystąpił błąd. Spróbuj ponownie później");
                              }
                              return Center(child: CircularProgressIndicator());
                            }),
                      ],
                    ),
                  ),
                  Container(
                    width: 88.0,
                    height: 36.0,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO filtruj wyniki w kalendarzu
                      },
                      child: Text("Filtruj"),
                    ),
                  )
          ]
              ),
              Expanded(
                child: Column(
                  children: [
                    Divider(height: 1.0,),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Text("Skocz do daty",

                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    TextFormField(
                      controller: _dateController,
                      key: _dateInputKey,
                      onTap: () => _selectDate(context),
                      autofocus: false,
                      readOnly: true,
                      decoration: TextInputDecoration(labelText: "Wybierz datę").getInputDecoration(),
                    )
                  ],
                ),
              )
             ],
          )
        )
    );
  }
}