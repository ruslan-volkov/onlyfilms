import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';
import 'package:onlyfilms/models/season.dart';
import 'package:onlyfilms/models/tv.dart';
import 'package:onlyfilms/services/fetch.dart';
import 'package:onlyfilms/widgets/progress_indicator.dart';

class EpisodesPage extends StatefulWidget {
  EpisodesPage(this.element);
  final Tv element;

  @override
  State<StatefulWidget> createState() => EpisodesPageState();
}

class EpisodesPageState extends State<EpisodesPage>
    with AutomaticKeepAliveClientMixin {
  Future<ModelDetails> details;
  Future<List<Season>> seasons;

  void initState() {
    super.initState();
    details = getDetails(type: MediaType.tv, id: widget.element.id);
    // seasons = getSeasons(
    //     tvId: widget.element.id,
    //     numberOfSeasons: widget.element.numberOfSeasons);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelDetails>(
        future: details,
        builder: (context, snapshotDetails) {
          return snapshotDetails.hasData
              ? FutureBuilder<List<Season>>(
                  future: getSeasons(
                      tvId: snapshotDetails.data.id,
                      numberOfSeasons:
                          (snapshotDetails.data as Tv).numberOfSeasons),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? _buildSeasons(snapshot.data)
                        : Container(
                            height: ScreenUtil().setWidth(300),
                            width: ScreenUtil().setWidth(300),
                            child: CustomProgressIndicator(),
                          );
                  })
              : Container(
                  height: ScreenUtil().setWidth(300),
                  width: ScreenUtil().setWidth(300),
                  child: CustomProgressIndicator(),
                );
        });

    return FutureBuilder<List<Season>>(
        future: seasons,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? _buildSeasons(snapshot.data)
              : Container(
                  height: ScreenUtil().setWidth(300),
                  width: ScreenUtil().setWidth(300),
                  child: CustomProgressIndicator(),
                );
        });
  }

  Widget _buildSeasons(List<Season> _seasons) {
    return Column(
      children: [for (var season in _seasons) Text(season.name)],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
