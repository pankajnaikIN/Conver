import 'package:flutter/material.dart';
import 'package:conver/outlines/message_outline.dart';
import 'dart:collection';

class MessageOutlineList extends ChangeNotifier {
  List<MessageOutline> _messageOutline = [
    MessageOutline(
        phoneNumber: '+917003551330',
        image: 'images/halsey.jpg',
        name: 'Halsey',
        lastSeen: 'yesterday'),
    MessageOutline(
        phoneNumber: '+919748810585',
        image: 'images/halsey.jpg',
        name: 'Mom',
        lastSeen: 'yesterday'),
    MessageOutline(
        phoneNumber: '+918005700285',
        image: 'images/halsey.jpg',
        name: 'Apoorva',
        lastSeen: 'yesterday'),
    MessageOutline(
        phoneNumber: '+917687089343',
        image: 'images/halsey.jpg',
        name: 'Pankaj',
        lastSeen: 'yesterday'),
    MessageOutline(
        phoneNumber: '+918981147438',
        image: 'images/halsey.jpg',
        name: 'Karen',
        lastSeen: 'yesterday'),
    MessageOutline(
        phoneNumber: '+917003551339',
        image: 'images/halsey.jpg',
        name: 'Katherine',
        lastSeen: 'yesterday'),
    MessageOutline(
        phoneNumber: '+919748954120',
        image: 'images/halsey.jpg',
        name: 'Neha',
        lastSeen: 'yesterday'),
  ];

  UnmodifiableListView<MessageOutline> get messageOutline {
    return UnmodifiableListView(_messageOutline);
  }

  int get messageOutlineLength {
    return _messageOutline.length;
  }

  void addMessageOutline(MessageOutline newTaskTitle) {
//    final task = MessageOutline(name: newTaskTitle);
    _messageOutline.add(newTaskTitle);
    print(_messageOutline.length);
    notifyListeners();
  }

  void updateMessageOutline(MessageOutline task) {
//    task.toggleDone();
    notifyListeners();
  }

  void deleteMessageOutline(MessageOutline task) {
    bool r = _messageOutline.remove(task);
    print(r);
    print(_messageOutline.length);
    notifyListeners();
  }
}
