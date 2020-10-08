import 'package:flutter/material.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';
import 'package:onlyfilms/models/movie.dart';
import 'package:onlyfilms/screens/details/arc_banner_image.dart';
import 'package:onlyfilms/screens/details/poster.dart';
import 'package:onlyfilms/screens/details/rating_information.dart';

class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.movie);
  final ModelDetails movie;

  List<Widget> _buildCategoryChips(TextTheme textTheme) {
    return (movie as Movie).genres.map((genre) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(genre.name),
          labelStyle: textTheme.caption,
          backgroundColor: Colors.black12,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.name,
          style: textTheme.headline6,
        ),
        movie.mediaType == MediaType.movie || movie.mediaType == MediaType.tv
            ? {SizedBox(height: 8.0), RatingInformation(movie)}
            : Container(),
        SizedBox(height: 12.0),
        Row(children: _buildCategoryChips(textTheme)),
      ],
    );

    return Stack(
      children: [
        movie.mediaType == MediaType.movie || movie.mediaType == MediaType.tv
            ? Padding(
                padding: const EdgeInsets.only(bottom: 140.0),
                child: ArcBannerImage((movie as Movie).backdropPath),
              )
            : Container(),
        Positioned(
          bottom: 0.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Poster(
                movie.image,
                height: 180.0,
              ),
              SizedBox(width: 16.0),
              Expanded(child: movieInformation),
            ],
          ),
        ),
      ],
    );
  }
}
