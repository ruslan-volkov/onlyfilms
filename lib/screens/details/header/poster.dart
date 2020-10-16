import 'package:flutter/material.dart';
import 'package:onlyfilms/screens/details/image_viewer.dart';
import 'package:onlyfilms/widgets/image_loader.dart';

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
        color: Theme.of(context).backgroundColor,
        child: ImageViewer(
          posterUrl,
          Image.network(posterUrl,
              fit: BoxFit.cover,
              width: width,
              height: height, loadingBuilder: (BuildContext context,
                  Widget child, ImageChunkEvent loadingProgress) {
            return CustomImageLoader(width, height, child, loadingProgress);
          }),
        ));
  }
}
