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
  List<Model> items;
  var controller = ScrollController();
  StreamController<List<Model>> _modelStream;
  var page = 1;
  var previousQuery = "";

  Future<void> loadData(String query) async {
    final data = await fetchAll(query, page);
    if (previousQuery != query) {
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
    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.position.pixels == 0) {
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
    final posterRatio = 0.7;
    final posterHeight = 200.0;
    final posterWidth = posterRatio * posterHeight;

    return Container(
        color: Color(0xFF383B57),
        child: Container(
            padding: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            margin: EdgeInsets.only(
              top: 32.0,
            ),
            // width: size.width * 0.90,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      onChanged: (value) => {loadData(value)},
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF585C89),
                        hintStyle:
                            TextStyle(color: Colors.white70, fontSize: 16),
                        hintText: 'Enter a search term',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.teal,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.search_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 8,
                      child: Container(
                        child: StreamBuilder<List<Model>>(
                          stream: _modelStream.stream,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                  controller: controller,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: posterRatio,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 5.0,
                                  ),
                                  padding: EdgeInsets.all(8),
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Card(
                                          elevation: 18.0,
                                          // shape: RoundedRectangleBorder(
                                          //     borderRadius: BorderRadius.all(
                                          //         Radius.circular(10.0))),
                                          child: snapshot
                                                  .data[index].image.isNotEmpty
                                              ? Image.network(
                                                  snapshot.data[index].image,
                                                  fit: BoxFit.cover,
                                                  height: posterHeight,
                                                  width: posterWidth,
                                                )
                                              : Image.asset(
                                                  "assets/image_not_found.png",
                                                  fit: BoxFit.cover,
                                                  height: posterHeight,
                                                  width: posterWidth,
                                                ),
                                          clipBehavior: Clip.antiAlias,
                                          margin: EdgeInsets.all(8.0),
                                        ),
                                        Text(
                                          snapshot.data[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              return Center(child: Container());
                            }
                          },
                        ),
                      ))
                ])));
  }

  void _scrollToTop() {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }
}
