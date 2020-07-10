import 'package:conver/screens/addscreen.dart';
import 'package:conver/screens/opening_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:conver/messageOutlineList.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

//final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class Messages extends StatefulWidget {
  static const String id = 'messages';
//  final FirebaseUser user;
//
//  Messages({this.user});
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

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
        title: Text('Messages'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.account_box),
                  onPressed: () {
                    Navigator.pushNamed(context, AddScreen.id);
                  }),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
//                    print(loggedInUser);
                    _auth.signOut();
                    Navigator.pop(context);
                    Navigator.pushNamed(context, OpeningScreen.id);
                  }),
            ],
          ),
        ],
      ),
      body: Consumer<MessageOutlineList>(
          builder: (context, messageOutlineList, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = messageOutlineList.messageOutline[index];
            return
//              SafeArea(
//              child: Column(
//                children: <Widget>[

                task
//                ],
//              ),
//            )
                ;
          },
          itemCount: messageOutlineList.messageOutlineLength,
        );
      }),
    );
  }
}
