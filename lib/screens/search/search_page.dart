import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/services/fetch.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  final types = ["Movie", "Tv Series", "Person"];
  var _selected = [];
  List<Model> items;
  var scrollController = ScrollController();
  var textFieldController = TextEditingController();
  StreamController<List<Model>> _modelStream;
  var page = 1;
  var previousQuery = "";

  Future<void> loadData(String query) async {
    final data = await fetchAll(query, page);
    if (previousQuery != query || query.isEmpty) {
      items.clear();
      _scrollToTop();
      page = 1;
    }
    previousQuery = query;
    items.addAll(data);
    _modelStream.add(items);
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
          loadData(previousQuery);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final posterRatio = 0.6;

    return SafeArea(
        child: Container(
            color: Color(0xFF383B57),
            child: Container(
                padding: EdgeInsets.only(
                    left: size.width * 0.05, right: size.width * 0.05),
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
                                  child: TextField(
                                    controller: textFieldController,
                                    onChanged: (value) => {loadData(value)},
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFF585C89),
                                      hintStyle: TextStyle(
                                          color: Colors.white70, fontSize: 16),
                                      hintText: "Search",
                                      prefixIcon: const Icon(
                                        Icons.search_sharp,
                                        color: Colors.white,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () => {
                                          textFieldController.clear(),
                                          items.clear(),
                                          _modelStream.add(items)
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //     flex: 1,
                                //     child: Material(
                                //       type: MaterialType.transparency,
                                //       color: Color(0xFF383B57),
                                //       child: IconButton(
                                //         highlightColor: Color(0xFF383B57),
                                //         disabledColor: Colors.black26,
                                //         color: Colors.white,
                                //         icon: Icon(Icons.filter_alt_sharp),
                                //         onPressed: () {
                                //           showBottomSheet(
                                //               context: context,
                                //               builder: (context) => Filters());
                                //         },
                                //       ),
                                //     ))
                              ])),
                      Expanded(flex: 1, child: filters()),
                      Expanded(
                          flex: 8,
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
                                        crossAxisCount: 2,
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
                                                        .image.isNotEmpty
                                                    ? Image.network(
                                                        snapshot
                                                            .data[index].image,
                                                        fit: BoxFit.fill,
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
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes
                                                                  : null,
                                                            ),
                                                          );
                                                        },
                                                      )

                                                    // OptimizedCacheImage(
                                                    //     imageUrl: snapshot
                                                    //         .data[index].image,
                                                    //     imageBuilder: (context,
                                                    //             imageProvider) =>
                                                    //         Container(
                                                    //       decoration:
                                                    //           BoxDecoration(
                                                    //         image: DecorationImage(
                                                    //             image:
                                                    //                 imageProvider,
                                                    //             fit: BoxFit
                                                    //                 .cover),
                                                    //       ),
                                                    //     ),
                                                    //     placeholder: (context,
                                                    //             url) =>
                                                    //         RefreshProgressIndicator(),
                                                    //     errorWidget: (context,
                                                    //             url, error) =>
                                                    //         Icon(Icons.error),
                                                    //   )
                                                    // Image.network(
                                                    //     snapshot
                                                    //         .data[index].image,
                                                    //     fit: BoxFit.cover,
                                                    //   )
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
                                                  snapshot.data[index].title,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0,
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
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.center,
      child: ListView(
        primary: true,
        shrinkWrap: true,
        children: <Widget>[
          Wrap(
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 20.0,
            runSpacing: 0.0,
            children: List<Widget>.generate(
                types.length, // place the length of the array here
                (int index) {
              return FilterChip(
                selected: _selected.contains(types[index]),
                onSelected: (test) => {
                  setState(() {
                    !_selected.contains(types[index])
                        ? _selected.add(types[index])
                        : _selected.remove(types[index]);
                  })
                },
                label: Text(types[index]),
                labelStyle: TextStyle(color: Colors.white),
                backgroundColor: Color(0xFF2A6A71),
                selectedColor: Color(0xFF1B998B),
                elevation: 10,
                pressElevation: 5,
              );
              // return Chip(label: Text(types[index]));
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
}
