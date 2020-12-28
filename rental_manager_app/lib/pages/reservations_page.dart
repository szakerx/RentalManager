import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/guest.dart';
import 'package:rental_manager_app/model/person.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/model/rental_object.dart';
import 'package:rental_manager_app/model/reservation.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';

class ReservationsPage extends StatefulWidget {
  Reservation reservation;

  ReservationsPage({this.reservation});

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

  Future<List<Guest>> _guestsList;
  Future<List<RentalObject>> _rentalObjectsList;
  String _selectedRentalObject;
  String _selectedGuest;

  @override
  void initState() {
    super.initState();
    _rentalObjectsList = Remote.getRentalObjects();
    _guestsList = Remote.getGuests();

    if (widget.reservation == null) {
      _guestsAmountController.text = "0";
      _childrenAmountController.text = "0";
      _sinceDateController.text = getFormattedDate(DateTime.now());
      _untilDateController.text = getFormattedDate(DateTime.now());
    } else {
      _guestsAmountController.text = widget.reservation.guestsCount.toString();
      _childrenAmountController.text = widget.reservation.childrenCount.toString();
      _sinceDateController.text = getFormattedDateFromString(widget.reservation.startDate);
      _untilDateController.text = getFormattedDateFromString(widget.reservation.endDate);
      _selectedGuest = widget.reservation.person.id.toString();
      _selectedRentalObject = widget.reservation.rentalObject.id.toString();
      _descriptionController.text = widget.reservation.description;
      _priceController.text = widget.reservation.price.toString();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Rezerwacja")),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  FutureBuilder<List<Guest>>( // Person
                    future: _guestsList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                            hint: Text("Wybierz gościa"),
                            value: _selectedGuest,
                            items: _buildGuestsList(snapshot.data),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedGuest = newValue;
                              });
                            });
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Wystąpił błąd. Spróbuj ponownie później."));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0)),
                  FutureBuilder<List<RentalObject>>(
                    future: _rentalObjectsList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                            hint: Text("Wybierz obiekt"),
                            value: _selectedRentalObject,
                            items: _buildRentalObjectsList(snapshot.data),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRentalObject = newValue;
                              });
                            });
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
                              controller: _guestsAmountController,
                              decoration:
                              TextInputDecoration(labelText: "Liczba gości")
                                  .getInputDecoration(),
                              keyboardType: TextInputType.number),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
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
                                if (_selectedSinceDate.isAfter(_selectedUntilDate)) {
                                  return "Błędne dane";
                                }
                                return null;
                              },
                              onTap: () => _selectSinceDate(context),
                              decoration:
                              TextInputDecoration(labelText: "Od")
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
                              if (_selectedSinceDate.isAfter(_selectedUntilDate)) {
                                return "";
                              }
                              return null;
                            },
                            onTap: () => _selectUntilDate(context),
                            decoration:
                            TextInputDecoration(labelText: "Do")
                                .getInputDecoration(),
                            keyboardType: TextInputType.number),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: TextInputDecoration(labelText: "Cena").getInputDecoration(),
                    inputFormatters: [CurrencyTextInputFormatter(
                      locale: 'pl',
                      decimalDigits: 0,
                      symbol: 'PLN ',
                    )],
                    keyboardType: TextInputType.number,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: TextInputDecoration(labelText: "Opis")
                        .getInputDecoration(),
                    maxLines: null,
                    maxLength: 255,
                    minLines: 7,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //TODO zapisz do bazy
                        if (_formKey.currentState.validate()) {
                          Navigator.pop(context);

                        } else {

                        }
                      },
                      child: Text("Zapisz"))
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

  Future<void> _selectSinceDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedSinceDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedSinceDate)
      setState(() {
        _selectedSinceDate = picked;
        _sinceDateController.text =
        "${getFormattedDate(_selectedSinceDate)}";
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
        _untilDateController.text =
        "${getFormattedDate(_selectedUntilDate)}";
      });
  }

  String getFormattedDate(DateTime d) {
    return "${d.day}.${d.month}.${d.year}";
  }
  String getFormattedDateFromString(String date) {
    DateTime d = DateTime.parse(date);
    return "${d.day}.${d.month}.${d.year}";
  }
}