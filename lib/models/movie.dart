import 'package:onlyfilms/models/genre.dart';
import 'package:onlyfilms/models/model.dart';

class Movie extends Model {
  final String releaseDate;
  final String overview;
  final int revenue;
  final String status;
  final int voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final String backdropPath;
  final int runtime;

  Movie(
      {id,
      mediaType,
      title,
      this.releaseDate,
      image,
      this.overview,
      this.revenue,
      this.status,
      this.voteAverage,
      this.voteCount,
      this.genres,
      this.backdropPath,
      this.runtime})
      : super(id: id, image: image, mediaType: mediaType, title: title);

  factory Movie.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJsonBase(json);
    return Movie(
        id: model.id,
        mediaType: model.mediaType,
        title: json["title"],
        releaseDate: json["release_date"],
        overview: json["overview"],
        revenue: json["revenue"],
        status: json["status"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        genres: Genre.getGenresFromJsonArray(json["genres"]),
        backdropPath: Model.getImageUrl(json["backdrop_path"]),
        runtime: json["runtime"],
        image: Model.getImageUrl(json["poster_path"]));
  }
}
