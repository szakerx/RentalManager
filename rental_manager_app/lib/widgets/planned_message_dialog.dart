import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/message_scheme.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:rental_manager_app/widgets/text_input_decoration.dart';

class PlannedMessageDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlannedMessageDialogState();
  }
}

class PlannedMessageDialogState extends State<PlannedMessageDialog> {
  Future<List<MessageScheme>> _messageSchemes;
  String _selectedMessageScheme;

  TextEditingController _daysController = TextEditingController();

  TextEditingController _timeController = TextEditingController();
  bool _timeValidated = true;
  TimeOfDay _selectedTime = TimeOfDay.now();

  List<String> _beforeAfterDropdownItems = ["przed", "po"];
  String _selectedBeforeAfter = "przed";

  @override
  void initState() {
    super.initState();
    _messageSchemes = Remote.getMessageSchemes();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: 440.0,
        child: Column(
          children: [
            Text("Nowe powiadomienie",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 27.0),),
            Divider(),
            FutureBuilder<List<MessageScheme>>(
                future: _messageSchemes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButtonFormField(
                        hint: Text("Wybierz schemat wiadomości"),
                        value: _selectedMessageScheme,
                        items: _buildMessageSchemesList(snapshot.data),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedMessageScheme = newValue;
                          });
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Wystąpił bład. Spróbuj ponownie później"),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            Padding(padding: EdgeInsets.all(20.0), child:
            Text("Kiedy wysłać?", style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),),),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: TextFormField(
                        controller: _daysController,
                        decoration: TextInputDecoration(labelText: "Ilość")
                            .getInputDecoration(),
                        keyboardType: TextInputType.number),
                  ),
                ),
                Text("dni"),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child:
                    DropdownButtonFormField(
                        value: _selectedBeforeAfter,
                        items: _beforeAfterDropdownItems.map((element) {
                          return DropdownMenuItem(
                            child: new Text(element),
                            value: element,
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedBeforeAfter = newValue;
                          });
                        }),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: _selectedBeforeAfter == "przed" ? Text("rezerwacją o") : Text("rezerwacji o"),
                ),
                Flexible(
                  child: TextFormField(
                    controller: _timeController,
                    onTap: () => _selectTime(context),
                    autofocus: false,
                    readOnly: true,
                    decoration: TextInputDecoration(
                            labelText: "Godzina",
                            errorText:
                                _timeValidated ? null : "Nie wybrano godziny")
                        .getInputDecoration(),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            ElevatedButton(onPressed: () {
              //Todo: zapisać do bazy
              Navigator.pop(context);
            }, child: Text("Zapisz"))
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null && picked != _selectedTime)
      setState(() {
        _timeValidated = true;
        _selectedTime = picked;
        _timeController.text = "${_selectedTime.format(context)}";
      });
  }

  List<DropdownMenuItem> _buildMessageSchemesList(List<MessageScheme> list) {
    List<DropdownMenuItem> elements = List();
    list.forEach((element) {
      elements.add(DropdownMenuItem(
        child: Text(element.name),
        value: element.id.toString(),
      ));
    });
    return elements;
  }
}
