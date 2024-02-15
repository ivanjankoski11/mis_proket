import 'package:flutter/material.dart';

class Settings {
  CircleAvatar icon;
  String text;

  Settings({required this.icon, required this.text});
}

List<Settings> settings = [
  Settings(
      icon: CircleAvatar(
          child: Icon(Icons.message, color: Colors.white),
          backgroundColor: Color.fromRGBO(187, 127, 192, 1),
          radius: 25),
      text: "Messages"),
  Settings(
      icon: CircleAvatar(
          child: Icon(Icons.notifications, color: Colors.white),
          backgroundColor: Color.fromRGBO(187, 119, 75, 1),
          radius: 25),
      text: "Notifications"),
  Settings(
      icon: CircleAvatar(
          child: Icon(Icons.contacts, color: Colors.white),
          backgroundColor: Color.fromRGBO(250, 181, 10, 1),
          radius: 25),
      text: "Contacts"),
  Settings(
      icon: CircleAvatar(
          child: Icon(Icons.logout, color: Colors.white),
          backgroundColor: Color.fromRGBO(197, 119, 75, 1),
          radius: 25),
      text: "Logout"),
];
