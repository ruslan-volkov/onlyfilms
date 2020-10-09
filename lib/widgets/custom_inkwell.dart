import 'package:flutter/material.dart';

class CustomInkwell extends StatelessWidget {
  CustomInkwell(this.child, this.onTap);
  final Widget child;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      new Positioned.fill(bottom: 0.0, child: child),
      new Positioned.fill(
        child: new Material(
            color: Colors.transparent,
            child: new InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.blueGrey.withOpacity(0.5),
              onTap: onTap,
            )),
      )
    ]);
  }
}
