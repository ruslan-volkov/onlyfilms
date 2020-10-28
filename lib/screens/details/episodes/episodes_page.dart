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
      await _reloadItems();
      _cachedItems.addAll(s);
      itemsSink.add(_cachedItems);
      // _limit += 10;
    } catch (e) {
      itemsSink.addError(e);
    }
  }

  Future<void> _reloadItems() async {
    userSeasons = await getSeasonsAndEpisodes(widget.element.id);
  }

  void initState() {
    super.initState();
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
          header: Stack(
            children: <Widget>[
              SizedBox(
                width: ScreenUtil().setWidth(1080),
                height: ScreenUtil().setHeight(100),
                child: LinearProgressIndicator(
                  value: _seasonProgress(season),
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).accentColor),
                ),
              ),
              Align(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Padding(
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(15)),
                        child: Text(season.name,
                            style: textTheme.subtitle1
                                .copyWith(fontSize: ScreenUtil().setSp(45)))),
                    CircularCheckBox(
                        value: _hasSeenAllSeasonEpisodes(season),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        onChanged: (bool x) {
                          setState(() {
                            if (x) {
                              _seeSeason(season);
                            } else {
                              _unseeSeason(season);
                            }
                          });
                        }),
                  ]))
            ],
          ),
          theme: ExpandableThemeData(
              iconColor: theme.accentColor,
              tapBodyToCollapse: true,
              tapBodyToExpand: true,
              tapHeaderToExpand: true,
              hasIcon: false),
          expanded: _buildEpisodes(season.episodes),
        )
    ]);
  }

  Widget _buildEpisodes(List<Episode> _episodes) {
    return Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
        child: Column(
          children: [
            for (var episode in _episodes)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: ScreenUtil().setWidth(800),
                    child: Text(
                      _episodeTitle(episode),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                      width: ScreenUtil().setWidth(100),
                      child: CircularCheckBox(
                          value: _hasSeenEpisode(episode),
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          onChanged: (bool x) {
                            setState(() {
                              if (x) {
                                _seeEpisode(episode);
                              } else {
                                _unseeEpisode(episode);
                              }
                            });
                          }))
                ],
              )
          ],
        ));
  }

  void _seeSeason(Season season) {
    seeSeason(widget.element.id, season);
    var userSeason = _getUserSeason(season.seasonNumber);
    var eps = season.episodes
        .map((se) =>
            new Ep(id: se.episodeNumber.toString(), seen: DateTime.now()))
        .toList();
    if (userSeason != null) {
      userSeason.season.seen = DateTime.now();
      userSeason.episodes.addAll(eps);
    } else {
      userSeasons.add(_createSeason(season.seasonNumber, eps));
    }
  }

  void _unseeSeason(Season season) {
    unseeSeason(widget.element.id, season);
    var userSeason = _getUserSeason(season.seasonNumber);

    if (userSeason != null) {
      userSeason.episodes.clear();
    }
  }

  void _seeEpisode(Episode episode) {
    seeEpisode(widget.element.id, episode);
    var userSeason = _getUserSeason(episode.seasonNumber);
    if (userSeason != null) {
      if (userSeason.episodes != null) {
        var userEpisode = userSeason.episodes.firstWhere(
            (element) => element.id == episode.episodeNumber.toString(),
            orElse: () => null);
        if (userEpisode != null) {
          userEpisode.seen = DateTime.now();
        } else {
          userSeason.episodes.add(new Ep(
              id: episode.episodeNumber.toString(), seen: DateTime.now()));
        }
      }
    } else {
      userSeasons.add(_createSeason(
          episode.seasonNumber,
          new List<Ep>.from([
            new Ep(id: episode.episodeNumber.toString(), seen: DateTime.now())
          ])));
    }
  }

  void _unseeEpisode(Episode episode) {
    unseeEpisode(widget.element.id, episode);
    var userSeason = _getUserSeason(episode.seasonNumber);
    if (userSeason != null && userSeason != null) {
      userSeason.episodes.removeWhere(
          (element) => element.id == episode.episodeNumber.toString());
    }
  }

  bool _hasSeenAllSeasonEpisodes(Season season) {
    var userSeason = _getUserSeason(season.seasonNumber);
    if (userSeason == null) {
      return false;
    }
    for (var episode in season.episodes) {
      if (!_userSeasonHasEpisode(userSeason, episode.episodeNumber)) {
        return false;
      }
    }

    return true;
  }

  bool _hasSeenEpisode(Episode episode) {
    var userSeason = _getUserSeason(episode.seasonNumber);
    if (userSeason != null &&
        userSeason.episodes != null &&
        _userSeasonHasEpisode(userSeason, episode.episodeNumber)) {
      return true;
    }
    return false;
  }

  double _seasonProgress(Season season) {
    var counter = 0;
    var userSeason = _getUserSeason(season.seasonNumber);
    if (userSeason == null) {
      return 0;
    }
    for (var episode in season.episodes) {
      if (_userSeasonHasEpisode(userSeason, episode.episodeNumber)) {
        counter++;
      }
    }

    return counter / season.episodes.length;
  }

  FollowObj _getUserSeason(int seasonNumber) {
    return userSeasons.firstWhere(
        (element) => element.season.id == seasonNumber.toString(),
        orElse: () => null);
  }

  bool _userSeasonHasEpisode(FollowObj userSeason, int episodeNumber) {
    return userSeason.episodes.any((e) => e.id == episodeNumber.toString());
  }

  FollowObj _createSeason(int seasonNumber, List<Ep> episodes) {
    return new FollowObj(
        season: new Ep(id: seasonNumber.toString(), seen: DateTime.now()),
        episodes: episodes);
  }

  String _episodeTitle(Episode episode) {
    return "S${episode.seasonNumber.toString().padLeft(2, '0')} " +
        "E${episode.episodeNumber.toString().padLeft(2, '0')} ${episode.name}";
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
