import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/image_api.dart';
import 'package:onlyfilms/screens/details/image_viewer.dart';

class ImageScroller extends StatelessWidget {
  ImageScroller(this.photoUrls);
  final List<ImageApi> photoUrls;

  Widget _buildPhoto(BuildContext context, int index) {
    var photo = photoUrls[index];

    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ImageViewer(
          photo.filePath,
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.network(
              photo.filePath,
              width: ScreenUtil().setHeight(300) * photo.aspectRatio,
              height: ScreenUtil().setHeight(150),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox.fromSize(
          size: const Size.fromHeight(150.0),
          child: ListView.builder(
            itemCount: photoUrls.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 8.0, left: 20.0),
            itemBuilder: _buildPhoto,
          ),
        ),
      ],
    );
  }
}
