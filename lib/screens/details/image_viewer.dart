import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  ImageViewer(this.url, this.child);
  final Widget child;
  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Container(
                            child: PhotoView(
                          imageProvider: NetworkImage(url),
                        ))),
              )
            },
        child: child);
  }
}
