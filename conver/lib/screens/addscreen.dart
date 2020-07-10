import 'package:conver/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:conver/messageOutlineList.dart';
import 'package:conver/outlines/message_outline.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatelessWidget {
  static String phoneNumber;
  static String image;
  static String name;
  static String lastSeen;
  static const String id = 'addscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        leading: IconButton(
          icon: Icon(
              (Platform.isAndroid) ? Icons.arrow_back : Icons.arrow_back_ios,
              color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add Contact'),
//        actions: <Widget>[
//          Row(
//            children: <Widget>[
//              IconButton(
//                  icon: Icon(Icons.account_box),
//                  onPressed: () {
//                    Navigator.pushNamed(context, AddScreen.id);
//                  }),
//              IconButton(
//                  icon: Icon(Icons.close),
//                  onPressed: () {
////              _auth.signOut();
////              Navigator.pop(context);
//                  }),
//            ],
//          ),
//        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Number',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  phoneNumber = newText;
                },
              ),
              Text(
                'image',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  image = 'image/halsey.jgp';
                },
              ),
//            FlatButton(
//              onPressed: () {
//                image = 'image/halsey.jgp';
//              },
//              child: Text('Add image'),
//            ),
              Text(
                'name',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  name = newText;
                },
              ),
              Text(
                'last seen',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextField(
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  lastSeen = 'yesterday';
                },
              ),
//            FlatButton(
//              onPressed: () {
//                name = 'Apoorva';
//              },
//              child: Text('Add name'),
//            ),
//            FlatButton(
//              onPressed: () {
//                lastSeen = 'yesterday';
//              },
//              child: Text('lastSeen'),
//            ),
              FlatButton(
                onPressed: () {
                  Provider.of<MessageOutlineList>(context, listen: false)
                      .addMessageOutline(MessageOutline(
                    phoneNumber: phoneNumber,
                    image: image,
                    name: name,
                    lastSeen: lastSeen,
                  ));
//                Provider.of<TaskData>(context).addTask(newTaskTitle);
                  Navigator.pop(context);
                },
                child: Text(
                  'ADD',
                  style: TextStyle(fontSize: 50),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
