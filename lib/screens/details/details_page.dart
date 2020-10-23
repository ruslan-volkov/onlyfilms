import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/image_api.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';
import 'package:onlyfilms/screens/details/episodes/episodes_page.dart';
import 'package:onlyfilms/screens/details/info/info_page.dart';
import 'package:onlyfilms/screens/details/header/details_header.dart';
import 'package:onlyfilms/services/fetch.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/widgets/progress_indicator.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(this.element);
  final Model element;

  @override
  State<StatefulWidget> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
// class DetailsPageState extends State<DetailsPage> with SingleTickerProviderStateMixin {
  final bodyGlobalKey = GlobalKey();
  TabController _tabController;
  ScrollController _scrollController;
  bool fixedScroll = false;

  Future<ModelDetails> details;
  Future<List<ImageApi>> photos;
  Future<List<Model>> cast;

  Widget _buildCarousel(ModelDetails data) {
    return DetailsHeader(data);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
    details = getDetails(type: widget.element.mediaType, id: widget.element.id);
    photos = getImages(type: widget.element.mediaType, id: widget.element.id);
    cast = getCast(type: widget.element.mediaType, id: widget.element.id);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (fixedScroll) {
      _scrollController.jumpTo(0);
    }
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelDetails>(
        future: details,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  body: widget.element.mediaType == MediaType.tv
                      ? NestedScrollView(
                          controller: _scrollController,
                          headerSliverBuilder: (context, value) {
                            return [
                              SliverToBoxAdapter(
                                  child: _buildCarousel(snapshot.data)),
                              SliverToBoxAdapter(
                                child: TabBar(
                                  controller: _tabController,
                                  labelColor: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color,
                                  isScrollable: true,
                                  tabs: [
                                    Container(
                                        width: ScreenUtil().setWidth(540),
                                        child: Tab(
                                            text: AppLocalizations.of(context)
                                                .translate("About"))),
                                    Container(
                                        width: ScreenUtil().setWidth(540),
                                        child: Tab(
                                            text: AppLocalizations.of(context)
                                                .translate("Episodes"))),
                                  ],
                                ),
                              ),
                            ];
                          },
                          body: Container(
                            color: Theme.of(context).backgroundColor,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                SingleChildScrollView(
                                    child: _info(snapshot.data)),
                                SingleChildScrollView(
                                    child: EpisodesPage(snapshot.data)),
                              ],
                            ),
                          ),
                        )
                      : SafeArea(
                          bottom: false,
                          child: SizedBox.expand(
                              child: Container(
                                  color: Theme.of(context).backgroundColor,
                                  child: SingleChildScrollView(
                                      child: Column(children: [
                                    _buildCarousel(snapshot.data),
                                    _info(snapshot.data)
                                  ])))),
                        ))
              : Container(
                  height: ScreenUtil().setHeight(500),
                  width: ScreenUtil().setWidth(500),
                  color: Colors.transparent,
                  child: CustomProgressIndicator());
        });
  }

  Widget _info(ModelDetails data) {
    return InfoPage(data);
  }
}
