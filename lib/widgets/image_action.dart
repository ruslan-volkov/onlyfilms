import 'package:flutter/material.dart';

class ImageAction extends StatelessWidget {
  ImageAction(this.child, this.onTap);
  final Widget child;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(borderRadius: BorderRadius.circular(4.0), child: child),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.blueGrey.withOpacity(0.5),
              onTap: () => onTap(),
            ),
          ),
        ),
      ],
    );
  }
}
