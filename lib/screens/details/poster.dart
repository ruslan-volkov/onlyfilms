import 'package:flutter/material.dart';
import 'package:onlyfilms/screens/details/image_viewer.dart';

class Poster extends StatelessWidget {
  static const POSTER_RATIO = 0.7;

  Poster(
    this.posterUrl, {
    this.height = 100.0,
  });

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = POSTER_RATIO * height;

    return Material(
        borderRadius: BorderRadius.circular(4.0),
        elevation: 2.0,
        child: GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImageViewer(posterUrl)),
            )
          },
          child: Image.network(
            posterUrl,
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        ));
  }
}
