import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/screens/details/details_page.dart';
import 'package:onlyfilms/services/fetch.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/widgets/custom_inkwell.dart';
import 'package:onlyfilms/widgets/progress_indicator.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  final types = [MediaType.movie, MediaType.tv, MediaType.person];
  Timer searchOnStoppedTyping;
  MediaType selected = MediaType.multi;
  List<Model> items;
  var scrollController = ScrollController();
  var textFieldController = TextEditingController();
  StreamController<List<Model>> _modelStream;
  var page = 1;
  var previousQuery = "";

  Future<void> loadData(String query, bool refresh) async {
    final data = await fetchAll(type: selected, query: query, page: page);
    if (query.isEmpty || refresh) {
      _clearAndScrollToTop();
    }
    previousQuery = query;
    items.addAll(data);
    _modelStream.add(items);
  }

  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping.cancel()); // clear timer
    }
    setState(
        () => searchOnStoppedTyping = new Timer(duration, () => search(value)));
  }

  search(value) {
    if (previousQuery != value) {
      loadData(value, true);
    } else {
      loadData(value, false);
    }
  }

  @override
  void initState() {
    super.initState();
    items = new List<Model>();
    _modelStream = StreamController<List<Model>>();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // you are at top position
        } else {
          // you are at bottom position
          page++;
          loadData(previousQuery, false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    final posterRatio = 0.6;

    return SafeArea(
        child: Container(
            color: Theme.of(context).backgroundColor,
            child: Container(
                // padding: EdgeInsets.only(
                //     left: size.width * 0.05, right: size.width * 0.05),
                margin: EdgeInsets.only(
                  top: 5.0,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.05,
                                          right: size.width * 0.05),
                                      child: TextField(
                                        controller: textFieldController,
                                        onChanged: _onChangeHandler,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(40)),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(15.0),
                                            ),
                                          ),
                                          filled: true,
                                          focusColor: Colors.black,
                                          fillColor: Theme.of(context)
                                              .primaryColorDark,
                                          hintStyle: TextStyle(
                                              color: Colors.white70,
                                              fontSize: ScreenUtil().setSp(40)),
                                          hintText: AppLocalizations.of(context)
                                              .translate("Search"),
                                          prefixIcon: const Icon(
                                            Icons.search_sharp,
                                            color: Colors.white,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () => {
                                              textFieldController.clear(),
                                              _clearAndScrollToTop(),
                                            },
                                            icon: Icon(Icons.clear),
                                          ),
                                        ),
                                      )),
                                ),
                              ])),
                      Expanded(flex: 1, child: filters()),
                      Expanded(
                          flex: 11,
                          child: Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            child: StreamBuilder<List<Model>>(
                              stream: _modelStream.stream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return GridView.builder(
                                      controller: scrollController,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: posterRatio,
                                        crossAxisCount: 3,
                                      ),
                                      padding: EdgeInsets.zero,
                                      itemCount: snapshot.data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              flex: 10,
                                              child: Card(
                                                elevation: 18.0,
                                                child: snapshot.data[index]
                                                                .image !=
                                                            null &&
                                                        snapshot.data[index]
                                                            .image.isNotEmpty
                                                    ? CustomInkwell(
                                                        Image.network(
                                                          snapshot.data[index]
                                                              .image,
                                                          fit: BoxFit.cover,
                                                          loadingBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  ImageChunkEvent
                                                                      loadingProgress) {
                                                            if (loadingProgress ==
                                                                null)
                                                              return child;
                                                            return Center(
                                                              child: CustomProgressIndicator(
                                                                  value: loadingProgress
                                                                              .expectedTotalBytes !=
                                                                          null
                                                                      ? loadingProgress
                                                                              .cumulativeBytesLoaded /
                                                                          loadingProgress
                                                                              .expectedTotalBytes
                                                                      : null),
                                                            );
                                                          },
                                                        ),
                                                        () => Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      DetailsPage(
                                                                          snapshot
                                                                              .data[index])),
                                                            ))
                                                    : Image.asset(
                                                        "assets/image_not_found.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                clipBehavior: Clip.antiAlias,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text(
                                                  snapshot.data[index].name,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(35),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        );
                                      });
                                } else {
                                  return Center(child: Container());
                                }
                              },
                            ),
                          ))
                    ]))));
  }

  Widget filters() {
    return Theme(
      data: ThemeData.dark(),
      child: ListView(
        primary: true,
        shrinkWrap: true,
        children: <Widget>[
          Wrap(
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 20.0,
            runSpacing: 0.0,
            children: List<Widget>.generate(types.length, (int index) {
              return FilterChip(
                selected: selected == types[index],
                onSelected: (_value) => {
                  setState(() {
                    if (!(selected == types[index])) {
                      selected = types[index];
                    } else {
                      selected = MediaType.multi;
                    }
                    loadData(previousQuery, true);
                  })
                },
                label: Text(getMediaTypeName(types[index], context)),
                labelStyle: TextStyle(color: Colors.white),
                backgroundColor: Colors.blueGrey,
                selectedColor: Theme.of(context).splashColor,
                elevation: 10,
                pressElevation: 5,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void _clearAndScrollToTop() {
    items.clear();
    _modelStream.add(items);

    _scrollToTop();
    page = 1;
    previousQuery = "";
  }

  @override
  bool get wantKeepAlive => true;
}
