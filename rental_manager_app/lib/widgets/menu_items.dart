

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/pages/home_page.dart';
import 'package:rental_manager_app/pages/message_schemes_list_page.dart';
import 'package:rental_manager_app/widgets/side_menu_state.dart';
import 'package:rental_manager_app/widgets/text_with_icon.dart';

import 'custom_colors.dart';

class MenuItems extends StatefulWidget {
  final items = ["Kalendarz", "Obiekty", "Goście", "Powiadomienia"];
  final icons = [Icons.calendar_today, Icons.home, Icons.person, Icons.message];

  @override
  State<StatefulWidget> createState() {
    return MenuItemsState();
  }
}

class MenuItemsState extends State<MenuItems> {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  void goToPage(String pageName) {
    Widget page;
    switch (pageName) {
      case "Kalendarz":
        page = HomePage();
        break;
      case "Obiekty":
        page = HomePage(); //TODO zmienic
        break;
      case "Goście":
        page = HomePage(); //TODO zmienic
        break;
      case "Powiadomienia":
        page = MessageSchemesList();
        break;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Column(
              children: [
                Text('Witaj',
                  style: Theme.of(context).textTheme.headline1.copyWith(color: CustomColors.darkBlack),
                ),
                Text(FirebaseAuth.instance.currentUser.email,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20.0),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: CustomColors.lightGreen,
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (_, index){
                return InkWell(
                  onTap: (){
                    for(int i = 0; i < SideMenuState.isHighlighted.length; i++){
                      setState(() {
                        if (index == i) {
                          SideMenuState.isHighlighted[index] = true;
                        } else {
                          SideMenuState.isHighlighted[i] = false;
                        }
                      });
                    }
                    goToPage(widget.items[index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: SideMenuState.isHighlighted[index] ? CustomColors.darkGreen : CustomColors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50.0))
                    ),
                    margin: EdgeInsets.only(right: 20.0),
                    child: ListTile(
                      title: TextWithIcon(text: widget.items[index], icon: widget.icons[index], color: SideMenuState.isHighlighted[index] ? CustomColors.white : CustomColors.darkBlack),
                    ),
                  ),
                );
              }),
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: TextWithIcon(text: "Wyloguj", icon: Icons.exit_to_app),
          ),
          onTap: () {
            print("Wylogowano");
            _signOut();
          },
        )

      ]),
    );
  }
}

