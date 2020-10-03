import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  SignInButton(this.context, this.onPressed, this.text, this.logo);
  final BuildContext context;
  final Function onPressed;
  final String text;
  final Image logo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // match_parent
      child: OutlineButton(
        color: Colors.white,
        splashColor: Colors.grey,
        onPressed: () => onPressed(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logo,
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFFFFEAD),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
