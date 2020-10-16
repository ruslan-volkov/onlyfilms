import 'package:onlyfilms/services/fetch.dart';

class Genre {
  final int id;
  final String name;

  Genre(this.id, this.name);

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(json["id"], json["name"]);
  }

  static List<Genre> getGenresFromJsonArray(dynamic json) {
    List<Genre> genres = new List<Genre>();
    if (json != null) {
      for (var genre in json) {
        genres.add(Genre.fromJson(genre));
      }
    }
    return genres;
  }

  static List<Genre> getGenresFromIdsArray(dynamic json) {
    List<Genre> genres = new List<Genre>();
    if (json != null) {
      for (var genreId in json) {
        var genre = GenresApi.movieGenres
            .firstWhere((element) => element.id == genreId, orElse: () => null);
        if (genre == null) {
          genre = GenresApi.tvGenres.firstWhere(
              (element) => element.id == genreId,
              orElse: () => null);
        }

        if (genre != null) {
          genres.add(genre);
        }
      }
    }
    return genres;
  }
}
