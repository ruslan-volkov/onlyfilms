import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/image_api.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';
import 'package:onlyfilms/screens/details/actor_scroller.dart';
import 'package:onlyfilms/screens/details/details_header.dart';
import 'package:onlyfilms/screens/details/image_scroller.dart';
import 'package:onlyfilms/screens/details/storyline.dart';
import 'package:onlyfilms/services/fetch.dart';
import 'package:onlyfilms/widgets/progress_indicator.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(this.element);
  final Model element;

  @override
  State<StatefulWidget> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  Future<ModelDetails> details;
  Future<List<ImageApi>> photos;
  Future<List<Model>> cast;

  void initState() {
    super.initState();
    details = getDetails(type: widget.element.mediaType, id: widget.element.id);
    photos = getImages(type: widget.element.mediaType, id: widget.element.id);
    cast = getCast(type: widget.element.mediaType, id: widget.element.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: SizedBox.expand(
                child: Container(
                    // margin: EdgeInsets.only(
                    //   top: 50.0,
                    // ),
                    color: Theme.of(context).backgroundColor,
                    child: FutureBuilder<ModelDetails>(
                      future: details,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    DetailsHeader(snapshot.data),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Storyline(snapshot.data.overview),
                                    ),
                                    FutureBuilder<List<ImageApi>>(
                                        future: photos,
                                        builder: (context, snapshot) {
                                          return snapshot.hasData
                                              ? ImageScroller(snapshot.data)
                                              : Container(
                                                  height: ScreenUtil()
                                                      .setHeight(500),
                                                  width: ScreenUtil()
                                                      .setWidth(500),
                                                  child:
                                                      CustomProgressIndicator(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .splashColor),
                                                );
                                        }),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(20)),
                                    FutureBuilder<List<Model>>(
                                        future: cast,
                                        builder: (context, snapshot) {
                                          return snapshot.hasData
                                              ? ActorScroller(
                                                  widget.element.mediaType,
                                                  snapshot.data)
                                              : Container(
                                                  height: ScreenUtil()
                                                      .setHeight(500),
                                                  width: ScreenUtil()
                                                      .setWidth(500),
                                                  child:
                                                      CustomProgressIndicator(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .splashColor),
                                                );
                                        }),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(50)),
                                  ],
                                ),
                              )
                            : Center(
                                child: CustomProgressIndicator(
                                    backgroundColor:
                                        Theme.of(context).splashColor),
                              );
                      },
                    )))));
  }
}
