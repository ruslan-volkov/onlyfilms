import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class Storyline extends StatelessWidget {
  Storyline(this.storyline);
  final String storyline;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpandablePanel(
          header: Text("Story line",
              style: textTheme.subtitle1
                  .copyWith(fontSize: ScreenUtil().setSp(45))),
          theme: ExpandableThemeData(
              iconColor: theme.accentColor,
              tapBodyToCollapse: true,
              tapBodyToExpand: true,
              tapHeaderToExpand: true),
          collapsed: Text(
            storyline,
            softWrap: true,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyText2,
          ),
          expanded: Text(
            storyline,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
