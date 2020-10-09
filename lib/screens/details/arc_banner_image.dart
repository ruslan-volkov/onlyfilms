import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/screens/details/image_viewer.dart';

class ArcBannerImage extends StatelessWidget {
  ArcBannerImage(this.imageUrl);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = ScreenUtil().setHeight(500);
    return ClipPath(
        clipper: ArcClipper(),
        child: ImageViewer(
          imageUrl,
          Image.network(
            imageUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
        ));
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
