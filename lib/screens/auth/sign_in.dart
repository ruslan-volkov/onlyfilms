import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/widgets/alert_dialog.dart';

class SignIn {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signIn(BuildContext context, AuthCredential credential) async {
    try {
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user;

      if (user != null) {
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);

        print('signInWithGoogle succeeded: $user');

        return '$user';
      }
    } catch (error) {
      var errorCode = error.code;
      // The email of the user's account used.
      var email = error.email;
      var errorMessage = error.message;
      if (errorCode == "auth/account-exists-with-different-credential") {
        errorMessage = AppLocalizations.of(context)
                .translate("AccountAlreadyExistsSameEmail") +
            email +
            ".";
      }
      if (errorCode == "auth/user-disabled") {
        errorMessage =
            AppLocalizations.of(context).translate("AccountDisabled");
      }
      if (errorCode == "auth/invalid-credential") {
        errorMessage =
            AppLocalizations.of(context).translate("InvalidCredentials");
      }
      openOkDialog(
          context,
          AppLocalizations.of(context).translate("LoginFailed"),
          errorMessage,
          () => {});
      await signOut();
    }

    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
