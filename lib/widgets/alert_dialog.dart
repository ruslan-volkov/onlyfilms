import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OkAlertDialog extends StatelessWidget {
  OkAlertDialog(this.title, this.content, this.onPressed);
  final String title;
  final String content;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: onPressed,
        ),
      ],
    );
  }
}

openOkDialog(
    BuildContext context, String title, String content, Function onPressed) {
  executeActionBeforeClose() {
    onPressed();
    Navigator.pop(context);
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return OkAlertDialog(title, content, executeActionBeforeClose);
    },
  );
}
