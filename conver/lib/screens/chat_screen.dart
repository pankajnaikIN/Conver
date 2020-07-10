//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:conver/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

String contactName;
String phoneNumber;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  final String contactName;
  final String phoneNumber;
  ChatScreen({this.contactName, this.phoneNumber});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

//contactName = widget.contactName;
//phoneNumber = widget.phoneNumber;
class _ChatScreenState extends State<ChatScreen> {
  void handleClick(String value) {
    switch (value) {
      case 'mute':
        break;
      case 'Settings':
        break;
    }
  }

  final messageTextController = TextEditingController();
  String messageText;
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
        print(loggedInUser.phoneNumber);
      }
    } catch (e) {
      print(e);
    }
  }

//  contactName = widget.contactName;
//  phoneNumber = widget.phoneNumber;
  @override
  Widget build(BuildContext context) {
    contactName = widget.contactName;
    phoneNumber = widget.phoneNumber;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
//                _auth.signOut();
                    Navigator.pop(context);
                  }),
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'mute', 'settings'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ],
        title: Text(
          '$contactName',
        ),
        backgroundColor: Colors.green[900],
      ),
//    );
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
//          verticalDirection: VerticalDirection.down,
          children: <Widget>[
//            Container(
//                child: Column(
//              verticalDirection: VerticalDirection.up,
//              children: <Widget>[
            MessagesStream(),
//              ],
//            )),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Material(
                      color: Colors.white,
                      child: TextField(
                        style: TextStyle(color: Colors.black54, fontSize: 20),
                        cursorColor: Colors.green[900],
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      messageTextController.clear();
                      FocusScope.of(context).unfocus();
//                      int value=0;
//                      String l = await bringL();
//                      int value = 0;
//                      Future<String> l async=
//                      // Imagine that this function is more complex and slow.
//                      {
//                        Future.delayed(
//                          Duration(seconds: 2),
//                          () => 'Large Latte',
//                        );
//                      }

//                      var value = int.parse(Firestore.instance
//                          .collection(loggedInUser.phoneNumber)
//                          .document('$phoneNumber')
//                          .collection('messages')
//                          .snapshots()
//                          .length
//                          .toString());
//                      value = value + 1;
//                      int value = 0;
//                      _fireStore
//                          .collection(loggedInUser.phoneNumber)
//                          .document('$phoneNumber')
//                          .collection('messages')
//                          .document('value')
//                          .get()
//                          .then((val) {
//                        int v=val;);
                      //});
//                          .then((doc) {
//                        int val = doc.documents.length;
//                        value = val;
//                      });

//                      if (l.length != 0) value = int.parse(l);
//                      value = value + 1;
//                      print(value);
//                      then((myDocuments){
//                        print("${myDocuments.documents.length}");
//                      });
//                      String l = _fireStore
//                          .collection(loggedInUser.phoneNumber)
//                          .document('$phoneNumber')
//                          .collection('messages')
//                          .snapshots()
//                          .length
//                          .toString();
//                      int value = 0;
//                      if (l != null) value = int.parse(l);
//                      value += 1;
//                      print(value);

//                          .getDocuments
//                          .then((myDocuments) {
//                        print("${myDocuments.documents.length}");
//                      });

                      _fireStore
                          .collection(loggedInUser.phoneNumber)
                          .document('$phoneNumber')
                          .collection('messages')
                          .add({
                        'Text': messageText,
                        'Sender': loggedInUser.phoneNumber,
                      });
                      _fireStore
                          .collection('$phoneNumber')
                          .document(loggedInUser.phoneNumber)
                          .collection('messages')
                          .add({
                        'Text': messageText,
                        'Sender': loggedInUser.phoneNumber,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatefulWidget {
  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection(loggedInUser.phoneNumber)
          .document('$phoneNumber')
          .collection('messages')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
//        for(var message in messages){
//          final
//        }
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['Text'];
          final messageSender = message.data['Sender'];

          final currentUser = loggedInUser.phoneNumber;
//          if (currentUser == messageSender) {}

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender ? true : false,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
            child: ListView(
                reverse: false,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: messageBubbles));
      },
    );
  }
}

class MessageBubble extends StatefulWidget {
  MessageBubble({this.sender, this.text, this.isMe});
  final String sender;
  final String text;
  final bool isMe;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
//          Text(
//            widget.sender,
//            style: TextStyle(color: Colors.white70, fontSize: 12.0),
//          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: widget.isMe ? Radius.circular(30.0) : Radius.circular(0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topRight:
                  widget.isMe ? Radius.circular(0) : Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: widget.isMe ? Color(0xFF226402) : Colors.grey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
