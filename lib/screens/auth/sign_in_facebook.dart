import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:onlyfilms/screens/auth/sign_in.dart';
import 'package:onlyfilms/widgets/alert_dialog.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;

class FacebookSignin extends SignIn {
  Future<void> signInWithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential credential =
        FacebookAuthProvider.credential(result.accessToken.token);

    signIn(context, credential);
  }

  Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
    // await _auth.signOut();
  }
}
