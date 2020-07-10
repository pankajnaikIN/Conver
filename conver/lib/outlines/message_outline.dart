import 'package:flutter/material.dart';
import 'package:conver/screens/chat_screen.dart';
import 'package:conver/messageOutlineList.dart';
import 'package:provider/provider.dart';

class MessageOutline extends StatefulWidget {
  MessageOutline({this.phoneNumber, this.image, this.name, this.lastSeen});
  final String phoneNumber;
  final String image;
  final String name;
  final String lastSeen;

  @override
  _MessageOutlineState createState() => _MessageOutlineState();
}

class _MessageOutlineState extends State<MessageOutline> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
      onPressed: () {
//        Provider.of<MessageOutlineList>(context, listen: false)
//            .addMessageOutline(MessageOutline(
//                image: widget.image,
//                name: widget.name,
//                lastSeen: widget.lastSeen));
        Navigator.push(
            context, //ChatScreen.id
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                    contactName: widget.name,
                    phoneNumber: widget.phoneNumber)));
      },
      onLongPress: () {
        {
          Provider.of<MessageOutlineList>(context, listen: false)
              .deleteMessageOutline(MessageOutline(
                  image: widget.image,
                  name: widget.name,
                  lastSeen: widget.lastSeen));
//          MessageOutlineList().deleteMessageOutline(MessageOutline(
//              image: widget.image,
//              name: widget.name,
//              lastSeen: widget.lastSeen));
        }
      },
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(widget.image),
              ),
              Text(
                widget.name,
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.lastSeen,
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
            width: 350.0,
            child: Divider(
              color: Colors.teal[100],
            ),
          ),
        ],
      ),
    );
  }
}
