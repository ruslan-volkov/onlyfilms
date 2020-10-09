import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  ImageViewer(this.url, this.child);
  final Widget child;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.blueGrey.withOpacity(0.5),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Container(
                              child: PhotoView(
                            imageProvider: NetworkImage(url),
                          ))),
                );
              },
            ),
          ),
        ),
      ],
    );

    // return GestureDetector(
    //     onTap: () => {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => Container(
    //                         child: PhotoView(
    //                       imageProvider: NetworkImage(url),
    //                     ))),
    //           )
    //         },
    //     child: child);
  }
}
