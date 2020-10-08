import 'package:flutter/material.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';
import 'package:onlyfilms/models/movie.dart';
import 'package:onlyfilms/screens/details/actor_scroller.dart';
import 'package:onlyfilms/screens/details/details_header.dart';
import 'package:onlyfilms/screens/details/photo_scroller.dart';
import 'package:onlyfilms/screens/details/storyline.dart';
import 'package:onlyfilms/services/fetch.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage(this.movie);
  Model movie;
  ModelDetails movieDetails;

  @override
  State<StatefulWidget> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
// class DetailsPage extends StatelessWidget {

  Future<void> initState() async {
    super.initState();
    widget.movieDetails =
        await getDetails(type: widget.movie.mediaType, id: widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieDetailHeader(widget.movieDetails),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Storyline(widget.movieDetails.overview),
            ),
            // PhotoScroller(movie.photoUrls),
            SizedBox(height: 20.0),
            // ActorScroller(movie.actors),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
