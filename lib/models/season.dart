import 'package:onlyfilms/models/episode.dart';

class Season {
  final int id;
  final String name;
  final int seasonNumber;
  final String airDate;
  final List<Episode> episodes;

  Season({this.id, this.name, this.seasonNumber, this.airDate, this.episodes});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
        id: json["id"],
        name: json["name"],
        seasonNumber: json["season_number"],
        airDate: json["air_date"],
        episodes: Episode.getEpisodesFromJsonArray(json["episodes"]));
  }

  static List<Season> getSeasonsFromJsonArray(dynamic json) {
    List<Season> seasons = new List<Season>();
    if (json != null) {
      for (var season in json) {
        seasons.add(Season.fromJson(season));
      }
    }
    return seasons;
  }
}
