import 'dart:async';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/episode.dart';
import 'package:onlyfilms/models/season.dart';
import 'package:onlyfilms/models/tv.dart';
import 'package:onlyfilms/services/fetch.dart';
import 'package:onlyfilms/services/following.dart';
import 'package:onlyfilms/widgets/progress_indicator.dart';

class EpisodesPage extends StatefulWidget {
  EpisodesPage(this.element);
  final Tv element;

  @override
  State<StatefulWidget> createState() => EpisodesPageState();
}

class EpisodesPageState extends State<EpisodesPage>
    with AutomaticKeepAliveClientMixin {
  Future<List<Season>> seasons;
  // Future<List<dynamic>> userEpisodes;
  List<dynamic> userEpisodes;
  var b = true;

  List<Season> _cachedItems = List.from([]);
  StreamController<List<Season>> _streamController =
      StreamController<List<Season>>();
  StreamSink<List<Season>> get itemsSink => _streamController.sink;
  Stream<List<Season>> get itemsStream => _streamController.stream;
  Future<void> _addItems() async {
    // final params = {'count': '$_count', 'limit': '$_limit'};
    try {
      // Fetch newItems with http
      var s = await getSeasons(
          tvId: widget.element.id,
          numberOfSeasons: widget.element.numberOfSeasons);
      var test = await getEpisodes(widget.element.id);
      userEpisodes = test.docs;
      _cachedItems.addAll(s);
      itemsSink.add(_cachedItems);
      // _limit += 10;
    } catch (e) {
      itemsSink.addError(e);
    }
  }

  void initState() {
    super.initState();
    // seasons = getSeasons(
    //     tvId: widget.element.id,
    //     numberOfSeasons: widget.element.numberOfSeasons);
    // userEpisodes = getEpisodes(widget.element.id);
  }

  @override
  void didChangeDependencies() {
    if (_cachedItems.isEmpty) _addItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<dynamic>>(
        stream: itemsStream,
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
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    return Column(children: [
      for (var season in _seasons)
        ExpandablePanel(
          header: Row(children: [
            Text(season.name,
                style: textTheme.subtitle1
                    .copyWith(fontSize: ScreenUtil().setSp(45))),
            CircularCheckBox(
                value: _hasSeenAllSeasonEpisodes(season),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onChanged: (bool x) {
                  // if (x) {
                  //   seeSeason(widget.element.id, season);
                  // } else {
                  //   unseeSeason(widget.element.id, season);
                  // }
                  setState(() {
                    // b = !b;
                  });
                  // b = !b;
                }),
          ]),
          theme: ExpandableThemeData(
              iconColor: theme.accentColor,
              tapBodyToCollapse: true,
              tapBodyToExpand: true,
              tapHeaderToExpand: true),
          expanded: _buildEpisodes(season.episodes),
        )
    ]);
  }

  Widget _buildEpisodes(List<Episode> _episodes) {
    return Column(
      children: [
        for (var episode in _episodes)
          Row(
            children: [
              Text(episode.name),
              CircularCheckBox(
                  value: _hasSeenEpisode(episode),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onChanged: (bool x) {
                    // if (x) {
                    //   seeEpisode(widget.element.id, episode);
                    // } else {
                    //   unseeEpisode(widget.element.id, episode);
                    // }
                    setState(() {
                      // b = !b;
                    });
                    // b = !b;
                  })
            ],
          )
        // ListTile(
        //   title: Text(episode.name),

        // ),
      ],
    );
  }

  // _seeSeason(Season season) {}

  // _unseeSeason(Season season) {}

  // _seeEpisode(Season season) {}

  // _unseeEpisode() {}

  _hasSeenAllSeasonEpisodes(Season season) {
    var seen = true;
    for (var episode in season.episodes) {
      // TODO
      if (!userEpisodes.any((element) =>
          element.season == episode.seasonNumber &&
          element.episode == episode.episodeNumber)) {
        return false;
      }
    }
    return seen;
  }

  _hasSeenEpisode(Episode episode) {
    // TODO
    if (!userEpisodes.any((element) =>
        element.season == episode.seasonNumber &&
        element.episode == episode.episodeNumber)) {
      return false;
    }
    return true;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
