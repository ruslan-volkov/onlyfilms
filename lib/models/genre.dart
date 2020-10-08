class Genre {
  final int id;
  final String name;

  Genre(this.id, this.name);

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(json["id"], json["name"]);
  }

  static List<Genre> getGenresFromJsonArray(dynamic json) {
    List<Genre> genres = new List<Genre>();
    for (var genre in json) {
      genres.add(Genre.fromJson(genre));
    }
    return genres;
  }
}
