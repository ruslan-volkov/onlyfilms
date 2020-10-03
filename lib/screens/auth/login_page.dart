import 'package:flutter/material.dart';
import 'package:onlyfilms/screens/auth/sign_in_button.dart';
import 'package:onlyfilms/screens/auth/sign_in_facebook.dart';

import 'sign_in_google.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              SignInButton(
                  context,
                  GoogleSignin().signInWithGoogle,
                  'Sign in with Google',
                  Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 35.0)),
              SignInButton(
                  context,
                  FacebookSignin().signInWithFacebook,
                  'Sign in with Facebook',
                  Image(
                      image: AssetImage("assets/facebook_logo.png"),
                      height: 35.0)),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _signInButton() {
  //   return OutlineButton(
  //     splashColor: Colors.grey,
  //     onPressed: () {
  //       signInWithGoogle();
  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     highlightElevation: 0,
  //     borderSide: BorderSide(color: Colors.grey),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Sign in with Google',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
