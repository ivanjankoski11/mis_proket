import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:look/constants/all_constants.dart';
import 'package:look/constants/firestore_constants.dart';
import 'package:look/providers/auth_provider.dart';
import 'package:look/providers/profile_provider.dart';
import 'package:look/screens/chat_page.dart';
import 'package:look/screens/components/add_contact_dialog.dart';
import 'package:look/screens/login_page.dart';
import 'package:look/screens/profile_page.dart';
import 'package:look/screens/splash_page.dart';
import 'package:provider/provider.dart';

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LocalAuthProvider>(context);

    return Scaffold(
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add,color: Colors.white,size: 30),
        onPressed: () => showDialog(context: context, builder: (BuildContext context) => ContactsDialog()),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder()
            ),
      ),
      backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
        centerTitle: true,
        title: Text(
          'Contacts',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Expanded(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      var users = snapshot.data?.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: users?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              print(users?[index].get("photoUrl"));
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          ProfilePage(user: users?[index]),
                                      transitionDuration: Durations.long4,
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = Offset(0.0, 1.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      }));
                            },
                            child: Ink(
                              child: Container(
                                margin: const EdgeInsets.only(top: 15),
                                width: double.infinity,
                                child: Row(children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage: NetworkImage(
                                        users?[index].get("photoUrl") ?? ""),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        users?[index].get("displayName"),
                                        style: const TextStyle(
                                            fontSize: Sizes.dimen_16,
                                            fontWeight: FontWeight.w500),
                                      ))
                                ]),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
