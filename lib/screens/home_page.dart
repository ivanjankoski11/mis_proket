import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:look/constants/firestore_constants.dart';
import 'package:look/constants/size_constants.dart';
import 'package:look/providers/auth_provider.dart';
import 'package:look/screens/chat_page.dart';
import 'package:look/screens/map_screen.dart';
import 'package:look/screens/settings_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> data = [
    {'name': 'User 1', 'image': 'assets/user1.jpg'},
    {'name': 'User 2', 'image': 'assets/user2.jpg'},
    {'name': 'User 3', 'image': 'assets/user3.jpg'},
    {'name': 'User 3', 'image': 'assets/user3.jpg'},
    {'name': 'User 3', 'image': 'assets/user3.jpg'},
    {'name': 'User 3', 'image': 'assets/user3.jpg'},
    {'name': 'User 3', 'image': 'assets/user3.jpg'},
    {'name': 'User 3', 'image': 'assets/user3.jpg'},
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LocalAuthProvider>(context);
    final String userPhoto =
        authProvider.firebaseAuth.currentUser?.photoURL ?? "";

    return Scaffold(
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.location_pin, color: Colors.white, size: 30),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MapScreen()));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder()),
      ),
      backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "LookUp",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsPage(
                                user: authProvider.firebaseAuth.currentUser!,
                              )));
                },
                icon: const Icon(Icons.menu),
                iconSize: 30,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromRGBO(106, 91, 194, 1),
            height: 140,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where("displayName",
                      isNotEqualTo:
                          authProvider.firebaseAuth.currentUser?.displayName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                var users = snapshot.data?.docs;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: users?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                users?[index].get("photoUrl") ?? ""),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            users![index]
                                .get("displayName")
                                .toString()
                                .split(" ")[0],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.dimen_16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
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
                  Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    width: double.infinity,
                    child: const Text(
                      "Messages",
                      style: TextStyle(fontSize: Sizes.dimen_20),
                    ),
                  ),
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
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              ChatPage(
                                                  peerNickname: users?[index]
                                                      .get("displayName"),
                                                  peerAvatar: users?[index]
                                                      .get("photoUrl"),
                                                  peerId:
                                                      users?[index].get("id"),
                                                  userAvatar: authProvider
                                                          .firebaseAuth
                                                          .currentUser
                                                          ?.photoURL ??
                                                      ""),
                                          transitionDuration: Durations.long4,
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = Offset(0.0, 1.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));

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
                                            users?[index].get("photoUrl") ??
                                                ""),
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
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
        ],
      ),
    );
  }
}
// MaterialPageRoute(
//                                           builder: (context) => ChatPage(
//                                               peerNickname: users?[index]
//                                                   .get("displayName"),
//                                               peerAvatar: users?[index]
//                                                   .get("photoUrl"),
//                                               peerId: users?[index].get("id"),
//                                               userAvatar: authProvider
//                                                       .firebaseAuth
//                                                       .currentUser
//                                                       ?.photoURL ??
//                                                   ""))