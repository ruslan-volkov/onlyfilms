import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/screens/details/details_page.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/widgets/image_action.dart';
import 'package:onlyfilms/widgets/image_loader.dart';

class CastScroller extends StatelessWidget {
  CastScroller(this.mediaType, this.casts);
  final MediaType mediaType;
  final List<Model> casts;

  Widget _buildCast(BuildContext context, int index) {
    var cast = casts[index];
    var width = ScreenUtil().setHeight(400) * 0.65;
    var height = ScreenUtil().setHeight(400);
    return Padding(
      padding: EdgeInsets.only(right: ScreenUtil().setWidth(32)),
      child: Column(
        children: [
          ImageAction(
              cast.image != null && cast.image.isNotEmpty
                  ? Image.network(cast.image,
                      width: width,
                      height: height,
                      fit: BoxFit.fill, loadingBuilder: (BuildContext context,
                          Widget child, ImageChunkEvent loadingProgress) {
                      return CustomImageLoader(
                          width, height, child, loadingProgress);
                    })
                  : Image.asset(
                      "assets/image_not_found.png",
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                    ),
              () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailsPage(cast)),
                  )),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
            child: Text(
              cast.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(ScreenUtil().setHeight(500)),
      child: ListView.builder(
        itemCount: casts.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(top: 12.0, left: 20.0),
        itemBuilder: _buildCast,
      ),
    );
  }
}
