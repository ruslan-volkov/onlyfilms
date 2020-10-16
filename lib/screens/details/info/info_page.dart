import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/image_api.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/screens/details/info/cast_scroller.dart';
import 'package:onlyfilms/screens/details/info/image_scroller.dart';
import 'package:onlyfilms/screens/details/info/storyline.dart';
import 'package:onlyfilms/services/fetch.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/widgets/progress_indicator.dart';

class InfoPage extends StatefulWidget {
  InfoPage(this.element, this.overview);
  final Model element;
  final String overview;

  @override
  State<StatefulWidget> createState() => InfoPageState();
}

class InfoPageState extends State<InfoPage> with AutomaticKeepAliveClientMixin {
  Future<List<ImageApi>> photos;
  Future<List<Model>> cast;

  void initState() {
    super.initState();
    photos = getImages(type: widget.element.mediaType, id: widget.element.id);
    cast = getCast(type: widget.element.mediaType, id: widget.element.id);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Storyline(widget.overview),
      ),
      FutureBuilder<List<ImageApi>>(
          future: photos,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ImageScroller(snapshot.data)
                : Container(
                    height: ScreenUtil().setWidth(300),
                    width: ScreenUtil().setWidth(300),
                    child: CustomProgressIndicator(),
                  );
          }),
      SizedBox(height: ScreenUtil().setHeight(20)),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            AppLocalizations.of(context).translate("Cast"),
            style:
                textTheme.subtitle1.copyWith(fontSize: ScreenUtil().setSp(45)),
          ),
        ),
        FutureBuilder<List<Model>>(
            future: cast,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? CastScroller(widget.element.mediaType, snapshot.data)
                  : Container(
                      height: ScreenUtil().setWidth(300),
                      width: ScreenUtil().setWidth(300),
                      child: CustomProgressIndicator(),
                    );
            })
      ]),
      SizedBox(height: ScreenUtil().setHeight(50))
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}
