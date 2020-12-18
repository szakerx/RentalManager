import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/message_scheme.dart';
import 'package:rental_manager_app/model/remote.dart';
import 'package:rental_manager_app/widgets/side_menu.dart';

import 'message_scheme_page.dart';

class MessageSchemesList extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return MessageSchemesListState();
  }

}

class MessageSchemesListState extends State<MessageSchemesList> {
  Future<List<MessageScheme>> messageSchemes;

  @override
  void initState() {
    super.initState();
    messageSchemes = Remote.fetchMessageSchemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuDrawer(),
      appBar: AppBar(
        title: Text("Powiadomienia"),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageSchemePage()));
              },
              child: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<MessageScheme>>(
        future: messageSchemes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black38,
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (_, index){
                  return ListTile(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 10.0, 5.0),
                    title: Text(snapshot.data[index].name,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    subtitle: Text(snapshot.data[index].content),
                    trailing: FlatButton(
                      minWidth: 50.0,
                      height: 50.0,
                      padding: EdgeInsets.all(5.0),
                      child: Icon(Icons.delete),
                      onPressed: (){
                        //TODO usunac z bazy
                        setState(() {
                          messageSchemes = Remote.fetchMessageSchemes();
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MessageSchemePage.withData(snapshot.data[index])));
                    },
                  );
                }
            );
          } else if (snapshot.hasError) {
            return Text("Failed to fetch data");
          }
          return CircularProgressIndicator();
        }),
    );
  }

}