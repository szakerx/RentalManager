import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/message_scheme.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/pages/rental_objects_page.dart';
import 'package:rental_manager_app/widgets/custom_colors.dart';
import 'package:rental_manager_app/widgets/side_menu.dart';

class RentalObjectsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RentalObjectsListState();
  }
}

class RentalObjectsListState extends State<RentalObjectsListPage> {

  Future<List<MessageScheme>> _rentalObjects;
  List<MessageScheme> _filteredRentalObjects = List();
  bool searching = false;

  @override
  void initState() {
    super.initState();
    _rentalObjects = Remote.getMessageSchemes().then((value) => _filteredRentalObjects = value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MessageScheme>>(
        future: _rentalObjects,
        builder: (context, snapshot) {
      if (snapshot.hasData) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            setState(() {
              searching = false;
              _filteredRentalObjects = snapshot.data;
            });
          },
          child: Scaffold(
            drawer: SideMenuDrawer(),
            appBar: AppBar(
              title: searching ?
              TextField(
                autofocus: true,
                onChanged: (text) {
                  setState(() {
                    _filteredRentalObjects = snapshot.data.where((u) =>
                    (u.name
                        .toLowerCase()
                        .contains(text.toLowerCase())))
                        .toList();
                    print(_filteredRentalObjects);
                  });
                },) : Text("Obiekty"),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RentalObjectsPage()));
                    },
                    child: Icon(Icons.add)),
              ],
            ),
            body: ListView.builder(
                itemCount: _filteredRentalObjects.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    onTap: () {
                      searching = !searching;
                      _filteredRentalObjects = snapshot.data;
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RentalObjectsPage()));
                    },
                    title: Text(_filteredRentalObjects[index].name),
                    trailing: FlatButton(
                        minWidth: 50.0,
                        height: 50.0,
                        onPressed: () {
                          //TODO usunac z bazy
                          setState(() {
                            searching = !searching;
                            _filteredRentalObjects.removeAt(index);
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
}