import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/model/reservation.dart';
import 'package:rental_manager_app/pages/reservations_page.dart';
import 'package:rental_manager_app/widgets/custom_colors.dart';
import 'package:rental_manager_app/widgets/side_menu.dart';

class ReservationsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReservationsListState();
  }
}

class ReservationsListState extends State<ReservationsListPage> {

  Future<List<Reservation>> _reservations;
  List<Reservation> _filteredReservations = List();
  TextEditingController _searchingController = TextEditingController();
  bool searching = false;

  @override
  void initState() {
    super.initState();
    _reservations = Remote.getReservations().then((value) => _filteredReservations = value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservation>>(
        future: _reservations,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  searching = false;
                  _filteredReservations = snapshot.data;
                });
              },
              child: Scaffold(
                drawer: SideMenuDrawer(),
                appBar: AppBar(
                  title: searching ?
                  TextField(
                    autofocus: true,
                    controller: _searchingController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _searchingController.clear();
                          setState(() {
                            _filteredReservations = snapshot.data;
                          });
                        },
                        icon: Icon(Icons.clear, color: CustomColors.darkGreen,),
                      ),
                    ),
                    onEditingComplete: () {
                      _searchingController.clear();
                      setState(() {
                        _filteredReservations = snapshot.data;
                      });
                    },
                    onSubmitted: (_){
                      _searchingController.clear();
                      setState(() {
                        _filteredReservations = snapshot.data;
                      });
                    },
                    onChanged: (text) {
                      setState(() {
                        _filteredReservations = snapshot.data.where((u) =>
                        (( u.person.name
                            .toLowerCase()
                            .contains(text.toLowerCase()) ||
                           u.person.mail
                            .toLowerCase()
                            .contains(text.toLowerCase()) ||
                           u.rentalObject.name
                            .toLowerCase()
                            .contains(text.toLowerCase())
                        )))
                            .toList();
                      });
                    },) : Text("Rezerwacje"),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationsPage()));
                        },
                        child: Icon(Icons.add)),
                  ],
                ),
                body: ListView.builder(
                    itemCount: _filteredReservations.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        onTap: () {
                          searching = !searching;
                          _filteredReservations = snapshot.data;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationsPage(reservation: snapshot.data[index],)));
                        },
                        title: Text("${_filteredReservations[index].rentalObject.name}: ${_filteredReservations[index].person.name} ${_filteredReservations[index].person.surname}",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Cena: ${_filteredReservations[index].price} zł")
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Ilość gości: ${_filteredReservations[index].guestsCount + _filteredReservations[index].childrenCount}")
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Termin: ${getFormattedDate(_filteredReservations[index].startDate)} "
                                    "- ${getFormattedDate(_filteredReservations[index].endDate)}")
                            )
                          ],
                        ),
                        isThreeLine: true,
                        trailing: FlatButton(
                            minWidth: 50.0,
                            height: 50.0,
                            onPressed: () {
                              //TODO usunac z bazy
                              setState(() {
                                searching = !searching;
                                _filteredReservations.removeAt(index);
                                snapshot.data.removeAt(index);
                              });
                            },
                            child: Icon(Icons.delete)),
                      );
                    }),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              drawer: SideMenuDrawer(),
              appBar: AppBar(title: Text("Obiekty"),),
              body: Text("Wsytąpił błąd, spróbuj ponownie później."),
            );
          }
          return Scaffold(
            drawer: SideMenuDrawer(),
            appBar: AppBar(title: Text("Obiekty"),),
            body: Center(child: CircularProgressIndicator(),),
          );
        });
  }

  String getFormattedDate(String date) {
    DateTime d = DateTime.parse(date);
    return "${d.day}.${d.month}.${d.year}";
  }
}