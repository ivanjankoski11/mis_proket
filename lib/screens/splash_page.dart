import 'package:flutter/material.dart';
import 'package:look/providers/auth_provider.dart';
import 'package:look/screens/home_page.dart';
import 'package:look/screens/login_page.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    LocalAuthProvider authProvider = context.read<LocalAuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      return;
    }
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(106, 91, 194, 1),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Welcome to LookUp",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Smartest Chat Application",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
