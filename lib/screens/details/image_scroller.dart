import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/image_api.dart';
import 'package:onlyfilms/widgets/custom_image_loading_builder.dart';
import 'package:photo_view/photo_view.dart';

class ImageScroller extends StatelessWidget {
  ImageScroller(this.photoUrls);
  final List<ImageApi> photoUrls;

  Widget _buildPhoto(BuildContext context, int index) {
    var photo = photoUrls[index];
    var width = ScreenUtil().setWidth(300) * photo.aspectRatio;
    var height = ScreenUtil().setHeight(300);
    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Container(
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(photo.filePath,
                        width: width, height: height, fit: BoxFit.fitHeight,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                      return Container(
                          width: width,
                          height: height,
                          child: CustomImageLoadingBuilder(
                              child, loadingProgress));
                    })),
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
                                    imageProvider: NetworkImage(photo.filePath),
                                  ))),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )));
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
