import 'package:flutter/material.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';
import 'package:onlyfilms/screens/details/arc_banner_image.dart';
import 'package:onlyfilms/screens/details/poster.dart';
import 'package:onlyfilms/screens/details/rating_information.dart';

class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.element);
  final ModelDetails element;

  List<Widget> _buildCategoryChips(BuildContext context) {
    return element.genres.map((genre) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(genre.name),
          labelStyle: Theme.of(context).textTheme.caption,
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          element.name,
          style: textTheme.headline6,
        ),
        SizedBox(height: 8.0),
        element.mediaType != MediaType.person
            ? RatingInformation(element)
            : Container(),
        SizedBox(height: 12.0),
        SizedBox(
            height: 50.0,
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                children: _buildCategoryChips(context))),
      ],
    );

    if (element.backdropPath.isNotEmpty) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 140.0),
            child: ArcBannerImage(element.backdropPath),
          ),
          Positioned(
            bottom: 0.0,
            left: 16.0,
            right: 0.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Poster(
                  element.image,
                  height: 180.0,
                ),
                SizedBox(width: 10.0),
                Expanded(child: movieInformation),
              ],
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 60.0, left: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Poster(
              element.image,
              height: 180.0,
            ),
            SizedBox(width: 10.0),
            Expanded(child: movieInformation),
          ],
        ),
      );
    }
  }
}
