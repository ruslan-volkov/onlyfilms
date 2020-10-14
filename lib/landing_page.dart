import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlyfilms/navigator_page.dart';
import 'package:onlyfilms/screens/auth/login_page.dart';

class LandingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Container(child: LoginPage())));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Container(child: NavigatorPage())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPage();
  }
}
