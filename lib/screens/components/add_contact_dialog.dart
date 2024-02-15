import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:look/constants/size_constants.dart';
import 'package:look/constants/text_field_constants.dart';
import 'package:look/screens/profile_page.dart';

class ContactsDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactsDialogState();
}

class _ContactsDialogState extends State<ContactsDialog> {
  TextEditingController textEditingController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? users;

  @override
  void initState() {
    users = [];
  }

  @override
  void setState(users) {
    users = users;
  }

  @override
  Widget build(Object context) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? users;

    return Dialog(
      child: Container(
          height: 200,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(hintText: "Enter name..."),
                  ),
                  // ListView.builder(itemBuilder: (context, index) {
                  //   return Text(users?[index].get("displayName" ?? ""));
                  // })
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
                ),
              )
            ],
          )),
    );
  }
}
// StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('users')
//                         .where("displayName",
//                             isEqualTo: textEditingController.text)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return const CircularProgressIndicator();
//                       }

//                       var users = snapshot.data?.docs;
//                       return ;
//                     },
//                   )