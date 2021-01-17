import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/guest.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/widgets/custom_colors.dart';
import 'package:rental_manager_app/widgets/side_menu.dart';

import 'guests_page.dart';

class GuestsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GuestsListState();
  }
}

class GuestsListState extends State<GuestsListPage> {
  Future<List<Guest>> _guests;
  List<Guest> _filteredGuests = List();
  TextEditingController _searchingController = TextEditingController();
  bool searching = false;

  @override
  void initState() {
    super.initState();
    _guests = Remote.getGuests().then((value) => _filteredGuests = value);
  }

  void updateList() {
      setState(() {
        searching = false;
        _guests = Remote.getGuests().then((value) {
          _filteredGuests = value;
          return value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Guest>>(
        future: _guests,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  searching = false;
                  _filteredGuests = snapshot.data;
                });
              },
              child: Scaffold(
                drawer: SideMenuDrawer(),
                appBar: AppBar(
                  title: searching
                      ? TextField(
                          autofocus: true,
                          controller: _searchingController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                _searchingController.clear();
                                setState(() {
                                  _filteredGuests = snapshot.data;
                                });
                              },
                              icon: Icon(
                                Icons.clear,
                                color: CustomColors.darkGreen,
                              ),
                            ),
                          ),
                          onEditingComplete: () {
                            _searchingController.clear();
                            setState(() {
                              _filteredGuests = snapshot.data;
                            });
                          },
                          onSubmitted: (_) {
                            _searchingController.clear();
                            setState(() {
                              _filteredGuests = snapshot.data;
                            });
                          },
                          onChanged: (text) {
                            setState(() {
                              _filteredGuests = snapshot.data
                                  .where((u) => (u.person.name
                                          .toLowerCase()
                                          .contains(text.toLowerCase()) ||
                                      u.person.surname
                                          .toLowerCase()
                                          .contains(text.toLowerCase()) ||
                                      "${u.person.name} ${u.person.surname}"
                                          .toLowerCase()
                                          .contains(text.toLowerCase())))
                                  .toList();
                            });
                          },
                        )
                      : Text("Goście"),
                  actions: [
                    FlatButton(
                        minWidth: 50.0,
                        onPressed: () {
                          setState(() {
                            searching = !searching;
                          });
                        },
                        child: Icon(Icons.search)),
                    FlatButton(
                        minWidth: 50.0,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuestPage(this, isInEditMode: true,)));
                        },
                        child: Icon(Icons.add)),
                  ],
                ),
                body: ListView.builder(
                    itemCount: _filteredGuests.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        onTap: () {
                          searching = !searching;
                          _filteredGuests = snapshot.data;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuestPage(this, guest: snapshot.data[index],)));
                        },
                        title: Text(
                          "${_filteredGuests[index].person.name} ${_filteredGuests[index].person.surname}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(_filteredGuests[index].person.mail),
                        trailing: FlatButton(
                            minWidth: 50.0,
                            height: 50.0,
                            onPressed: () {
                              Remote.deleteGuest(_filteredGuests[index]).then((value) => updateList());
                            },
                            child: Icon(Icons.delete)),
                      );
                    }),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              drawer: SideMenuDrawer(),
              appBar: AppBar(
                title: Text("Goście"),
              ),
              body: Text("Wsytąpił błąd, spróbuj ponownie później."),
            );
          }
          return Scaffold(
            drawer: SideMenuDrawer(),
            appBar: AppBar(
              title: Text("Goście"),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
