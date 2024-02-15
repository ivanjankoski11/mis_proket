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

class SettingsPage extends StatefulWidget {
  final User user;

  const SettingsPage({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                backgroundImage: NetworkImage(widget.user.photoURL ?? ""),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.user?.displayName ?? "",
                  style: const TextStyle(
                      color: Colors.white, fontSize: Sizes.dimen_22))
            ],
          )),
        ),
        Expanded(
            child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: settings.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (settings[index].text == "Logout") {
                              authProvider.googleSignOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SplashPage()));
                            }
                            if (settings[index].text == "Contacts"){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                        ContactsPage()));
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(children: [
                              settings[index].icon,
                              const SizedBox(width: 15),
                              Text(
                                settings[index].text,
                                style: const TextStyle(
                                    fontSize: Sizes.dimen_16,
                                    fontWeight: FontWeight.w400),
                              )
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                )))
      ]),
    );
  }
}
