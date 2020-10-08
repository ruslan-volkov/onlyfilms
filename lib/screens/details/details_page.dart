import 'package:flutter/material.dart';
import 'package:onlyfilms/models/image_api.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';
import 'package:onlyfilms/screens/details/details_header.dart';
import 'package:onlyfilms/screens/details/photo_scroller.dart';
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
// class DetailsPage extends StatelessWidget {
  Future<ModelDetails> details;
  Future<List<ImageApi>> photos;

  void initState() {
    super.initState();
    details = getDetails(type: widget.element.mediaType, id: widget.element.id);
    photos = getImages(type: widget.element.mediaType, id: widget.element.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
            child: Container(
                color: Theme.of(context).backgroundColor,
                child: FutureBuilder<ModelDetails>(
                  future: details,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                MovieDetailHeader(snapshot.data),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Storyline(snapshot.data.overview),
                                ),

                                FutureBuilder<List<ImageApi>>(
                                    future: photos,
                                    builder: (context, snapshot) {
                                      return snapshot.hasData
                                          ? PhotoScroller(snapshot.data)
                                          : Container();
                                      // Center(
                                      //     child: CustomProgressIndicator(),
                                      //   );
                                    })
                                // SizedBox(height: 20.0),
                                // ActorScroller(movie.actors),
                                // SizedBox(height: 50.0),
                              ],
                            ),
                          )
                        : Center(
                            child: CustomProgressIndicator(),
                          );
                  },
                ))));
  }
}
