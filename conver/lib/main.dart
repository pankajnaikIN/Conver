import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/opening_screen.dart';
import 'screens/messages.dart';
import 'screens/chat_screen.dart';
import 'package:conver/screens/addscreen.dart';
import 'messageOutlineList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessageOutlineList(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: OpeningScreen.id,
        routes: {
          OpeningScreen.id: (context) => OpeningScreen(),
          Messages.id: (context) => Messages(),
          ChatScreen.id: (context) => ChatScreen(),
          AddScreen.id: (context) => AddScreen(),
        },
      ),
    );
  }
}
