import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:look/firebase_options.dart';
import 'package:look/providers/auth_provider.dart';
import 'package:look/providers/chat_provider.dart';
import 'package:look/screens/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _cameras = await availableCameras();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalAuthProvider>(
            create: (_) => LocalAuthProvider(
                firebaseFirestore: firebaseFirestore,
                prefs: prefs,
                googleSignIn: GoogleSignIn(),
                firebaseAuth: FirebaseAuth.instance)),
        Provider<ChatProvider>(
            create: (_) => ChatProvider(
                prefs: prefs,
                firebaseStorage: firebaseStorage,
                firebaseFirestore: firebaseFirestore))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Talk',
        home: SplashPage(),
      ),
    );
  }
}
