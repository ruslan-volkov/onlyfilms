class Episode {
  final int id;
  final String name;
  final int seasonNumber;
  final int episodeNumber;
  final String airDate;

  Episode(
      {this.id,
      this.name,
      this.seasonNumber,
      this.episodeNumber,
      this.airDate});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
        id: json["id"],
        name: json["name"],
        seasonNumber: json["season_number"],
        episodeNumber: json["episode_number"],
        airDate: json["air_date"]);
  }

  static List<Episode> getEpisodesFromJsonArray(dynamic json) {
    List<Episode> episodes = new List<Episode>();
    if (json != null) {
      for (var episode in json) {
        episodes.add(Episode.fromJson(episode));
      }
    }
    return episodes;
  }
}
