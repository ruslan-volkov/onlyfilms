import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/screens/home/home_category.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/widgets/custom_switch.dart';
import 'package:onlyfilms/widgets/progress_indicator.dart';
import 'package:onlyfilms/services/fetch.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  MediaType type = MediaType.movie;
  Future<List<Model>> upcoming;
  Future<List<Model>> popular;
  Future<List<Model>> topRated;
  Future<List<Model>> nowPlaying;
  Future<List<Model>> airingToday;
  Future<List<Model>> onTheAir;

  void initState() {
    super.initState();
    load();
  }

  load() {
    popular =
        getHomeCategoryItems(type: type, category: HomeCategoryType.popular);
    topRated =
        getHomeCategoryItems(type: type, category: HomeCategoryType.top_rated);
    if (type == MediaType.movie) {
      upcoming =
          getHomeCategoryItems(type: type, category: HomeCategoryType.upcoming);
      nowPlaying = getHomeCategoryItems(
          type: type, category: HomeCategoryType.now_playing);
    } else if (type == MediaType.tv) {
      airingToday = getHomeCategoryItems(
          type: type, category: HomeCategoryType.airing_today);
      onTheAir = getHomeCategoryItems(
          type: type, category: HomeCategoryType.on_the_air);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        child: Scaffold(
      body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(10),
                                right: ScreenUtil().setWidth(30),
                                bottom: ScreenUtil().setHeight(10)),
                            child: CustomSwitch(
                              width: ScreenUtil().setWidth(300),
                              height: ScreenUtil().setHeight(100),
                              activeColor: Theme.of(context).splashColor,
                              inactiveColor: Theme.of(context).accentColor,
                              activeText: AppLocalizations.of(context)
                                  .translate("Movies"),
                              inactiveText: AppLocalizations.of(context)
                                  .translate("Series"),
                              value: type == MediaType.movie,
                              onChanged: (value) {
                                setState(() {
                                  type = value ? MediaType.movie : MediaType.tv;
                                  load();
                                });
                              },
                            )),
                      ),
                    ]),
              ),
              Expanded(
                  flex: 14,
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                            height: ScreenUtil().setHeight(650),
                            child: FutureBuilder<List<Model>>(
                                future: type == MediaType.movie
                                    ? nowPlaying
                                    : airingToday,
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? HomeCategory(
                                          type == MediaType.movie
                                              ? AppLocalizations.of(context)
                                                  .translate("Now playing")
                                              : AppLocalizations.of(context)
                                                  .translate("Airing today"),
                                          snapshot.data)
                                      : CustomProgressIndicator(
                                          backgroundColor: Theme.of(context)
                                              .backgroundColor);
                                })),
                        SizedBox(
                            height: ScreenUtil().setHeight(650),
                            child: FutureBuilder<List<Model>>(
                                future: type == MediaType.movie
                                    ? upcoming
                                    : onTheAir,
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? HomeCategory(
                                          type == MediaType.movie
                                              ? AppLocalizations.of(context)
                                                  .translate("Upcoming")
                                              : AppLocalizations.of(context)
                                                  .translate("On the air"),
                                          snapshot.data)
                                      : CustomProgressIndicator(
                                          backgroundColor: Theme.of(context)
                                              .backgroundColor);
                                })),
                        SizedBox(
                            height: ScreenUtil().setHeight(650),
                            child: FutureBuilder<List<Model>>(
                                future: popular,
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? HomeCategory(
                                          AppLocalizations.of(context)
                                              .translate("Popular"),
                                          snapshot.data)
                                      : CustomProgressIndicator(
                                          backgroundColor: Theme.of(context)
                                              .backgroundColor);
                                })),
                        SizedBox(
                            height: ScreenUtil().setHeight(650),
                            child: FutureBuilder<List<Model>>(
                                future: topRated,
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? HomeCategory(
                                          AppLocalizations.of(context)
                                              .translate("Top rated"),
                                          snapshot.data)
                                      : CustomProgressIndicator(
                                          backgroundColor: Theme.of(context)
                                              .backgroundColor);
                                })),
                      ])),
            ],
          )),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
