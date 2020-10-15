import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/screens/details/details_page.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/widgets/image_action.dart';
import 'package:onlyfilms/widgets/image_loader.dart';

class ActorScroller extends StatelessWidget {
  ActorScroller(this.mediaType, this.cast);
  final MediaType mediaType;
  final List<Model> cast;

  Widget _buildActor(BuildContext context, int index) {
    var actor = cast[index];
    var width = ScreenUtil().setHeight(400) * 0.65;
    var height = ScreenUtil().setHeight(400);
    return Padding(
      padding: EdgeInsets.only(right: ScreenUtil().setWidth(32)),
      child: Column(
        children: [
          ImageAction(
              actor.image != null && actor.image.isNotEmpty
                  ? Image.network(actor.image,
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
                    MaterialPageRoute(builder: (context) => DetailsPage(actor)),
                  )),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
            child: Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            AppLocalizations.of(context).translate("Cast"),
            style:
                textTheme.subtitle1.copyWith(fontSize: ScreenUtil().setSp(45)),
          ),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(ScreenUtil().setHeight(500)),
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: _buildActor,
          ),
        ),
      ],
    );
  }
}
