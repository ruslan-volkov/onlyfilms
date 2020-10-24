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
  List<FollowObj> userSeasons;
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
      var test = await getSeasonsAndEpisodes(widget.element.id);
      userSeasons = test;
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
                  if (x) {
                    _seeSeason(season);
                  } else {
                    _unseeSeason(season);
                  }
                  // setState(() {
                  //   // b = !b;
                  // });
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
                    if (x) {
                      _seeEpisode(episode);
                    } else {
                      _unseeEpisode(episode);
                    }
                    // setState(() {
                    //   // b = !b;
                    // });
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

  _seeSeason(Season season) {
    seeSeason(widget.element.id, season);
    var userSeason = userSeasons.firstWhere(
        (element) => element.season.id == season.seasonNumber.toString(),
        orElse: () => null);
    if (userSeason != null) {
      userSeason.season.seen = DateTime.now();
    } else {
      userSeasons.add(new FollowObj(
          season: new Ep(
              id: season.seasonNumber.toString(), seen: DateTime.now())));
    }
  }

  _unseeSeason(Season season) {
    unseeSeason(widget.element.id, season);
    var userSeason = userSeasons.firstWhere(
        (element) => element.season.id == season.seasonNumber.toString(),
        orElse: () => null);
    if (userSeason != null) {
      userSeason.season.seen = null;
    }
  }

  _seeEpisode(Episode episode) {
    seeEpisode(widget.element.id, episode);
    var userSeason = userSeasons.firstWhere(
        (element) => element.season.id == episode.seasonNumber.toString(),
        orElse: () => null);
    if (userSeason != null) {
      var userEpisode = userSeason.episodes.firstWhere(
          (element) => element.id == episode.episodeNumber.toString(),
          orElse: () => null);
      if (userEpisode != null) {
        userEpisode.seen = DateTime.now();
      } else {
        userSeason.episodes.add(
            new Ep(id: episode.episodeNumber.toString(), seen: DateTime.now()));
      }
    }
  }

  _unseeEpisode(Episode episode) {
    unseeEpisode(widget.element.id, episode);
    var userSeason = userSeasons.firstWhere(
        (element) => element.season.id == episode.seasonNumber.toString(),
        orElse: () => null);
    if (userSeason != null) {
      var userEpisode = userSeason.episodes.firstWhere(
          (element) => element.id == episode.episodeNumber.toString(),
          orElse: () => null);
      if (userEpisode != null) {
        userEpisode.seen = null;
      }
    }
  }

  _hasSeenAllSeasonEpisodes(Season season) {
    // TODO
    if (userSeasons.any((element) =>
        element.season.id == season.seasonNumber.toString() &&
        element.season.seen != null)) {
      return true;
    }
    return false;
  }

  _hasSeenEpisode(Episode episode) {
    // TODO
    var season = userSeasons.firstWhere(
        (element) => element.season.id == episode.seasonNumber.toString(),
        orElse: () => null);
    if (season != null && season.season.seen != null) {
      return true;
    } else if (season != null &&
        season.episodes.any((e) =>
            e.id == episode.episodeNumber.toString() && e.seen != null)) {
      return true;
    }
    return false;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
