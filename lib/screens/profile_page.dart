import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:look/constants/all_constants.dart';
import 'package:look/constants/firestore_constants.dart';
import 'package:look/providers/auth_provider.dart';
import 'package:look/screens/chat_page.dart';
import 'package:look/screens/contacts_page.dart';
import 'package:look/screens/login_page.dart';
import 'package:look/screens/splash_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>>? user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LocalAuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Center(
              child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.user?.get("photoUrl") ?? ""),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.user?.get("displayName") ?? "",
                  style: const TextStyle(
                      color: Colors.white, fontSize: Sizes.dimen_22)),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ClipOval(
                    child: Container(
                      color: const Color.fromARGB(255, 111, 217, 115),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.phone, color: Colors.white,),),
                  ),
                  SizedBox(width: Sizes.dimen_20,),
                  ClipOval(
                    child: Container(color: const Color.fromARGB(255, 118, 168, 255),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.message,color: Colors.white,),),
                  )
                ],),
              )
            ],
          )),
        ),
      ]),
    );
  }
}
