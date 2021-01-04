import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_manager_app/model/guest.dart';
import 'package:rental_manager_app/model/planned_message.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/model/rental_object.dart';
import 'package:rental_manager_app/model/reservation.dart';
import 'package:rental_manager_app/model/user.dart';
import 'package:rental_manager_app/pages/reservations_list_page.dart';
import 'package:rental_manager_app/widgets/planned_message_dialog.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';
import 'package:rental_manager_app/widgets/text_with_icon.dart';

class ReservationsPage extends StatefulWidget {
  Reservation reservation;
  bool isInEditMode;
  ReservationsListState parent;

  ReservationsPage({this.parent, this.reservation, this.isInEditMode = false});

  @override
  State<StatefulWidget> createState() {
    return ReservationsPageState();
  }
}

class ReservationsPageState extends State<ReservationsPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _guestsAmountController = TextEditingController();
  TextEditingController _childrenAmountController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _sinceDateController = TextEditingController();
  DateTime _selectedSinceDate = DateTime.now();
  TextEditingController _untilDateController = TextEditingController();
  DateTime _selectedUntilDate = DateTime.now();

  Future<List<PlannedMessage>> _plannedMessagesFuture;
  List<PlannedMessage> _plannedMessages;

  Future<List<Guest>> _guestsListFuture;
  List<Guest> _guestsList;
  Future<List<RentalObject>> _rentalObjectsListFuture;
  List<RentalObject> _rentalObjectsList;
  String _selectedRentalObject;
  String _selectedGuest;

  @override
  void initState() {
    super.initState();
    _rentalObjectsListFuture =
        Remote.getRentalObjects().then((value) => _rentalObjectsList = value);
    _guestsListFuture = Remote.getGuests().then((value) => _guestsList = value);

    if (widget.reservation == null) {
      _guestsAmountController.text = "0";
      _childrenAmountController.text = "0";
      _sinceDateController.text = getFormattedDate(DateTime.now());
      _untilDateController.text = getFormattedDate(DateTime.now());
      _plannedMessagesFuture = Remote.getPlannedMessagesForReservation(-1)
          .then((value) => _plannedMessages = value);
    } else {
      _plannedMessagesFuture =
          Remote.getPlannedMessagesForReservation(widget.reservation.id)
              .then((value) => _plannedMessages = value);
      _guestsAmountController.text = widget.reservation.guestsCount.toString();
      _childrenAmountController.text =
          widget.reservation.childrenCount.toString();
      _sinceDateController.text =
          getFormattedDateFromString(widget.reservation.startDate);
      _untilDateController.text =
          getFormattedDateFromString(widget.reservation.endDate);
      _selectedGuest = widget.reservation.person == null
          ? null
          : widget.reservation.person.id.toString();
      _selectedRentalObject = widget.reservation.rentalObject == null
          ? null
          : widget.reservation.rentalObject.id.toString();
      _descriptionController.text = widget.reservation.description;
      _priceController.text = widget.reservation.price.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rezerwacja"),
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
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  FutureBuilder<List<Guest>>(
                    // Person
                    future: _guestsListFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IgnorePointer(
                          ignoring: !widget.isInEditMode,
                          child: DropdownButtonFormField(
                              hint: Text("Wybierz gościa"),
                              value: _selectedGuest,
                              items: _buildGuestsList(snapshot.data),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedGuest = newValue;
                                });
                              }),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                "Wystąpił błąd. Spróbuj ponownie później."));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  FutureBuilder<List<RentalObject>>(
                    future: _rentalObjectsListFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return IgnorePointer(
                          ignoring: !widget.isInEditMode,
                          child: DropdownButtonFormField(
                              hint: Text("Wybierz obiekt"),
                              value: _selectedRentalObject,
                              items: _buildRentalObjectsList(snapshot.data),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedRentalObject = newValue;
                                });
                              }),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                "Wystąpił błąd. Spróbuj ponownie później."));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 20.0),
                          child: TextFormField(
                              readOnly: !widget.isInEditMode,
                              controller: _guestsAmountController,
                              decoration:
                                  TextInputDecoration(labelText: "Liczba gości")
                                      .getInputDecoration(),
                              keyboardType: TextInputType.number),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                            readOnly: !widget.isInEditMode,
                            controller: _childrenAmountController,
                            decoration:
                                TextInputDecoration(labelText: "Liczba dzieci")
                                    .getInputDecoration(),
                            keyboardType: TextInputType.number),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 15.0, 10.0, 20.0),
                          child: TextFormField(
                              controller: _sinceDateController,
                              autofocus: false,
                              readOnly: true,
                              validator: (value) {
                                if (_selectedSinceDate
                                    .isAfter(_selectedUntilDate)) {
                                  return "Błędne dane";
                                }
                                return null;
                              },
                              onTap: () => _selectSinceDate(context),
                              decoration: TextInputDecoration(labelText: "Od")
                                  .getInputDecoration(),
                              keyboardType: TextInputType.number),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                            controller: _untilDateController,
                            autofocus: false,
                            readOnly: true,
                            validator: (value) {
                              if (_selectedSinceDate
                                  .isAfter(_selectedUntilDate)) {
                                return "";
                              }
                              return null;
                            },
                            onTap: () => _selectUntilDate(context),
                            decoration: TextInputDecoration(labelText: "Do")
                                .getInputDecoration(),
                            keyboardType: TextInputType.number),
                      ),
                    ],
                  ),
                  TextFormField(
                    readOnly: !widget.isInEditMode,
                    controller: _priceController,
                    decoration: TextInputDecoration(labelText: "Cena")
                        .getInputDecoration(),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextFormField(
                    readOnly: !widget.isInEditMode,
                    controller: _descriptionController,
                    decoration: TextInputDecoration(labelText: "Opis")
                        .getInputDecoration(),
                    maxLines: null,
                    maxLength: 255,
                    minLines: 7,
                  ),
                  FutureBuilder<List<PlannedMessage>>(
                      future: _plannedMessagesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: () {
                              List<Widget> elements = List();
                              _plannedMessages.forEach((element) {
                                elements.add(ListTile(
                                  title: Text(element.messageScheme.name),
                                  subtitle: Text(getFormattedTimeDateFromString(
                                      element.sendingTime)),
                                  trailing: IconButton(
                                    icon: Icon(Icons.cancel_outlined),
                                    onPressed: () {
                                      if (element.id != -1)
                                        Remote.deletePlannedMessage(element);
                                      setState(() {
                                        _plannedMessages
                                            .removeWhere((m) => m == element);
                                      });
                                    },
                                  ),
                                ));
                              });
                              return elements;
                            }(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child:
                                Text("Wystąpił bład. Spróbuj ponownie później"),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                  widget.isInEditMode
                      ? FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return PlannedMessageDialog(
                                      this,
                                      widget.reservation?.startDate ??
                                          _selectedSinceDate.toString(),
                                      widget.reservation?.endDate ??
                                          _selectedUntilDate.toString());
                                });
                          },
                          child: TextWithIcon(
                              text: "Dodaj powiadomienie", icon: Icons.add))
                      : Container(),
                  widget.isInEditMode
                      ? ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Reservation r = Reservation(
                                  id: widget.reservation == null
                                      ? -1
                                      : widget.reservation.id,
                                  startDate:
                                      _selectedSinceDate.toIso8601String(),
                                  endDate: _selectedUntilDate.toIso8601String(),
                                  description: _descriptionController.text,
                                  guestsCount:
                                      int.parse(_guestsAmountController.text),
                                  childrenCount:
                                      int.parse(_childrenAmountController.text),
                                  price: int.parse(_priceController.text),
                                  person: _guestsList
                                      .where((element) =>
                                          element.person.id.toString() ==
                                          _selectedGuest)
                                      .first
                                      .person,
                                  rentalObject: _rentalObjectsList
                                      .where((element) =>
                                          element.id.toString() ==
                                          _selectedRentalObject)
                                      .first,
                                  user: widget.reservation == null
                                      ? User(
                                          id: Firebase.FirebaseAuth.instance.currentUser.uid)
                                      : widget.reservation.user);
                              Remote.postReservation(r).then((value) {
                                _plannedMessages.forEach((element) {
                                  element.reservation = r;
                                  Remote.postPlannedMessage(element);
                                });
                                widget.parent.updateList();
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: Text("Zapisz"))
                      : Container(),
                ],
              ),
            )));
  }

  List<DropdownMenuItem> _buildRentalObjectsList(List<RentalObject> list) {
    List<DropdownMenuItem> elements = List();
    list.forEach((element) {
      elements.add(DropdownMenuItem(
        child: Text(element.name),
        value: element.id.toString(),
      ));
    });
    return elements;
  }

  List<DropdownMenuItem> _buildGuestsList(List<Guest> list) {
    List<DropdownMenuItem> elements = List();
    list.forEach((element) {
      elements.add(DropdownMenuItem(
        child: Text("${element.person.name} ${element.person.surname}"),
        value: element.person.id.toString(),
      ));
    });
    return elements;
  }

  void addPlannedMessage(PlannedMessage pm) {
    setState(() {
      pm.sendingTime = getSendingTime(pm);
      _plannedMessages.add(pm);
    });
  }

  String getSendingTime(PlannedMessage pm) {
    String result;
    if (pm.isBefore) {
      DateTime d = widget.reservation == null
          ? _selectedSinceDate
          : DateTime.parse(widget.reservation.startDate);
      result = DateTime(
              d.year, d.month, d.day - pm.days, pm.time.hour, pm.time.minute)
          .toIso8601String();
    } else {
      DateTime d = widget.reservation == null
          ? _selectedUntilDate
          : DateTime.parse(widget.reservation.endDate);
      result = DateTime(
              d.year, d.month, d.day + pm.days, pm.time.hour, pm.time.minute)
          .toIso8601String();
    }
    return result;
  }

  Future<void> _selectSinceDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedSinceDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        _selectedSinceDate = picked;
        _sinceDateController.text = "${getFormattedDate(_selectedSinceDate)}";
        _plannedMessages.forEach((element) {
          element.sendingTime = getSendingTime(element);
        });
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
        _selectedUntilDate = picked;
        _untilDateController.text = "${getFormattedDate(_selectedUntilDate)}";
        _plannedMessages.forEach((element) {
          element.sendingTime = getSendingTime(element);
        });
      });
  }

  String getFormattedDate(DateTime d) {
    return "${d.day}.${d.month}.${d.year}";
  }

  String getFormattedDateFromString(String date) {
    DateTime d = DateTime.parse(date);
    return "${d.day}.${d.month}.${d.year}";
  }

  String getFormattedTimeDateFromString(String date) {
    DateTime d = DateTime.parse(date);
    DateFormat formatter = DateFormat('dd.MM.yyyy hh:mm');
    return formatter.format(d);
  }
}
