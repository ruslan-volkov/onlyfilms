import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/model_details.dart';

class RatingInformation extends StatelessWidget {
  RatingInformation(this.element);
  final ModelDetails element;

  Widget _buildRatingBar(ThemeData theme, double voteAverage) {
    var stars = <Widget>[];
    for (var i = 1; i <= 5; i++) {
      var dec = voteAverage - voteAverage.truncate();
      var color = i <= voteAverage ? theme.accentColor : Colors.black12;
      IconData ic = Icons.star;
      if (i == voteAverage.floor()) {
        if (dec >= 0.3 && dec <= 0.7) {
          stars.add(Icon(
            ic,
            color: color,
          ));
          ic = Icons.star_half;
          i++;
        }
      }
      if (i == voteAverage.ceil()) {
        if (dec > 0.7) {
          color = theme.accentColor;
        }
      }
      var star = Icon(
        ic,
        color: color,
      );

      stars.add(star);
    }

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption;
    var voteAverage = getVoteAverage(element.voteAverage);

    var numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          voteAverage.toString(),
          style: textTheme.headline6.copyWith(
            fontWeight: FontWeight.w400,
            color: theme.accentColor,
          ),
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildRatingBar(theme, voteAverage),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        numericRating,
        SizedBox(width: ScreenUtil().setWidth(16)),
        starRating,
      ],
    );
  }

  getVoteAverage(double voteAverage) {
    return double.parse((voteAverage / 2).toStringAsFixed(1));
  }
}
