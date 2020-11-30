

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/widgets/text_with_icon.dart';

import 'custom_colors.dart';

class MenuItems extends StatefulWidget {
  final items = ["Kalendarz", "Obiekty", "Goście", "Powiadomienia"];
  final icons = [Icons.calendar_today, Icons.home, Icons.person, Icons.message];
  var isHighlighted = [true, false, false, false];

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
                    for(int i = 0; i < widget.isHighlighted.length; i++){
                      setState(() {
                        if (index == i) {
                          widget.isHighlighted[index] = true;
                        } else {                               //the condition to change the highlighted item
                          widget.isHighlighted[i] = false;
                        }
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.isHighlighted[index] ? CustomColors.darkGreen : CustomColors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50.0))
                    ),
                    margin: EdgeInsets.only(right: 20.0),
                    child: ListTile(                                     //the item
                      title: TextWithIcon(text: widget.items[index], icon: widget.icons[index], color: widget.isHighlighted[index] ? CustomColors.white : CustomColors.darkBlack),
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

