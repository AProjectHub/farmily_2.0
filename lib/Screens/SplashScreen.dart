// splash_screen.dart
import 'package:farmily/Screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../SignUpPages/SignUpPage.dart';
import 'CustomerHomePage.dart';
import 'Homescreen.dart';

class SplashScreen extends StatefulWidget {
  static const String screenId = 'splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
          () {
        final roleProvider = Provider.of<RoleProvider>(context, listen: false);
        final selectedRole = roleProvider.selectedRole;

        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              ),
            );
          } else {
            if (selectedRole == 'Customer') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CHomePage(),
                ),
              );
            } else if (selectedRole == 'Farmer') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CHomePage(),
                ),
              );
            } else if (selectedRole == 'Seller') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CHomePage(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/Images/logoicon.png'),
      ),
    );
  }
}