import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/widgets/alert_dialog.dart';

class AnonymousSignin {
  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      openOkDialog(context,
          AppLocalizations.of(context).translate("LoginFailed"), e, () => {});
    }
  }
}
