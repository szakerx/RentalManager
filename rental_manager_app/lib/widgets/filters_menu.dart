import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/message_scheme.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/model/rental_object.dart';
import 'package:rental_manager_app/widgets/reservations_dialog.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';

import 'calendar.dart';
import 'custom_colors.dart';
import 'filters_state.dart';

class FiltersMenuDrawer extends StatefulWidget {

  Calendar calendar;

  FiltersMenuDrawer(this.calendar);

  @override
  State<StatefulWidget> createState() {
    return FiltersMenuDrawerState();
  }
}

class FiltersMenuDrawerState extends State<FiltersMenuDrawer> {
  Future<List<RentalObject>> _rentalObjects;
  List<RentalObject> _rentalObjectsList;
  TextEditingController _goToDateController = TextEditingController();
  TextEditingController _sinceDateController = TextEditingController();
  TextEditingController _untilDateController = TextEditingController();

  bool _goToDateValidated = true;
  bool _sinceUntilValidated = true;

  DateTime _selectedGoToDate = DateTime.now();
  DateTime _selectedSinceDate = DateTime.now();
  DateTime _selectedUntilDate = DateTime.now();

  Future<void> _selectGoToDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedGoToDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedGoToDate)
      setState(() {
        _goToDateValidated = true;
        _selectedGoToDate = picked;
        _goToDateController.text =
            "${_selectedGoToDate.day}.${_selectedGoToDate.month}.${_selectedGoToDate.year}";
      });
  }

  Future<void> _selectSinceDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedSinceDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedSinceDate)
      setState(() {
        _sinceUntilValidated = true;
        _selectedSinceDate = picked;
        _sinceDateController.text =
        "${_selectedSinceDate.day}.${_selectedSinceDate.month}.${_selectedSinceDate.year}";
      });
  }

  Future<void> _selectUntilDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedUntilDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedUntilDate)
      setState(() {
        _sinceUntilValidated = true;
        _selectedUntilDate = picked;
        _untilDateController.text =
        "${_selectedUntilDate.day}.${_selectedUntilDate.month}.${_selectedUntilDate.year}";
      });
  }

  @override
  void initState() {
    super.initState();
    _rentalObjects = Remote.getRentalObjects().then((value) {
      _rentalObjectsList = value;
      if (FiltersState.checkedRentalObject == null) {
        FiltersState.checkedRentalObject = value.first.id.toString();
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 45.0),),
                Text("Filtrowanie", style: Theme.of(context).textTheme.headline1,),
                Column(children: [
                  Container(
                    height: MediaQuery. of(context). size. height/3,
                    child: FutureBuilder<List<RentalObject>>(
                        future: _rentalObjects,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ExpansionTile(
                              initiallyExpanded: true,
                                title: Text("Obiekty"),
                                children: [
                                  Container(
                                    height: MediaQuery. of(context). size. height/3 - 120,
                                    child: MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      child: ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (_, i) {
                                            return RadioListTile(
                                                title: Text(snapshot.data[i].name),
                                                value: snapshot.data[i].id.toString(),
                                                groupValue: FiltersState.checkedRentalObject,
                                                onChanged: (value) {
                                                  setState(() {
                                                    FiltersState.checkedRentalObject = value;
                                                  });
                                                });
                                          }),
                                    )
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: FiltersState.filtering ? null : () {
                                          FiltersState.filtering = true;
                                          widget.calendar.setFilteredReservations(snapshot.data.where((element) => element.id.toString() == FiltersState.checkedRentalObject).first);
                                          Navigator.of(context).pop();
                                          },
                                        child: Text("Filtruj"),
                                      ),
                                      Padding(padding: EdgeInsets.only(top: 10.0, right: 10.0)),
                                      ElevatedButton(
                                        onPressed: FiltersState.filtering ? () {
                                          FiltersState.filtering = true;
                                          widget.calendar.cancelFilteringReservations();
                                        } : null,
                                        child: Text("Zakończ"),
                                      ),
                                    ],
                                  )
                            ]);
                          } else if (snapshot.hasError) {
                            return Text(
                                "Wystąpił błąd. Spróbuj ponownie później");
                          }
                          return Center(child: CircularProgressIndicator());
                        }),
                  ),
                ]),
                Expanded(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(10.0)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "   Skocz do daty",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      TextFormField(
                        controller: _goToDateController,
                        onTap: () => _selectGoToDate(context),
                        autofocus: false,
                        readOnly: true,
                        decoration:
                            TextInputDecoration(labelText: "Wybierz datę", errorText: _goToDateValidated ? null : "Nie wybrano daty")
                                .getInputDecoration(),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(onPressed: () {
                          if (_goToDateController.text == "") {
                            setState(() {
                              _goToDateValidated = false;
                            });
                          } else {
                            _goToDateValidated = true;
                            widget.calendar.setSelectedDay(_selectedGoToDate);
                            Navigator.pop(context);
                          }

                        }, child: Text("Idź")),
                      ),
                      Divider(
                        height: 1.0,
                      ),
                      Padding(padding: EdgeInsets.all(10.0)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "   Sprawdź dostępność",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      TextFormField(
                        controller: _sinceDateController,
                        onTap: () => _selectSinceDate(context),
                        autofocus: false,
                        readOnly: true,
                        decoration:
                        TextInputDecoration(labelText: "Od", errorText: _sinceUntilValidated ? null : "Brak danych lub błędne dane")
                            .getInputDecoration(),
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      TextFormField(
                        controller: _untilDateController,
                        onTap: () => _selectUntilDate(context),
                        autofocus: false,
                        readOnly: true,
                        decoration:
                        TextInputDecoration(labelText: "Do")
                            .getInputDecoration(),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10.0)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(onPressed: () {
                          if (_selectedSinceDate.isBefore(_selectedUntilDate)
                              && _sinceDateController.text.isNotEmpty
                              && _untilDateController.text.isNotEmpty
                          ) {
                            //TODO idź do daty
                            showDialog(context: context,
                              builder: (context) {
                               return ReservationsDialog(_sinceDateController.text, _untilDateController.text, widget.calendar.getReservationsList(_selectedSinceDate, _selectedUntilDate), _rentalObjectsList);
                              });
                          } else {
                            setState(() {
                              _sinceUntilValidated = false;
                            });
                          }
                        }, child: Text("Sprawdź")),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
