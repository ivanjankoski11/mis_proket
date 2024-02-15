import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:look/constants/color_constants.dart';
import 'package:look/constants/size_constants.dart';
import 'package:look/constants/text_field_constants.dart';
import 'package:look/providers/auth_provider.dart';
import 'package:look/screens/home_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LocalAuthProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: Sizes.dimen_20,
            ),
            children: [
              vertical50,
              const Text(
                'Welcome to LookUp',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.dimen_26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              vertical30,
              const Text(
                'Login to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.dimen_22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              vertical50,
              Center(child: Image.asset('assets/images/back.png')),
              vertical50,
              GestureDetector(
                onTap: () async {
                  bool isSuccess = await authProvider.handleGoogleSignIn();
                  if (isSuccess) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Image.asset('assets/images/google_login.jpg'),
              ),
            ],
          ),
          Center(
            child: authProvider.status == Status.authenticating
                ? const CircularProgressIndicator(
                    color: AppColors.lightGrey,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
