import 'package:flutter/material.dart';
import 'package:onlyfilms/screens/auth/sign_in_anonymous.dart';
import 'package:onlyfilms/screens/auth/sign_in_button.dart';
import 'package:onlyfilms/screens/auth/sign_in_facebook.dart';
import 'package:onlyfilms/utilities/localization.dart';

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
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 8,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // FlutterLogo(size: 150),
                      SizedBox(height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SignInButton(
                            context: context,
                            onPressed: AnonymousSignin().signInAnonymously,
                            text: AppLocalizations.of(context)
                                .translate("SignInAnonymously"),
                          ),
                          SizedBox(height: 20),
                          SignInButton(
                              context: context,
                              onPressed: GoogleSignin().signInWithGoogle,
                              text: AppLocalizations.of(context)
                                  .translate("SignInGoogle"),
                              logo: Image(
                                  image: AssetImage(
                                      "assets/google_logo_small.png"),
                                  height: 35.0)),
                          SizedBox(height: 20),
                          SignInButton(
                              context: context,
                              onPressed: FacebookSignin().signInWithFacebook,
                              text: AppLocalizations.of(context)
                                  .translate("SignInFacebook"),
                              logo: Image(
                                  image: AssetImage(
                                      "assets/facebook_logo_small.png"),
                                  height: 35.0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          )),
    );
  }
}
