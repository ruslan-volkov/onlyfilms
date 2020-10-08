import 'package:onlyfilms/models/genre.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';

class Movie extends ModelDetails {
  final String releaseDate;
  final double revenue;
  final String status;
  final num voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final String backdropPath;
  final int runtime;

  Movie(
      {id,
      mediaType,
      name,
      this.releaseDate,
      image,
      overview,
      this.revenue,
      this.status,
      this.voteAverage,
      this.voteCount,
      this.genres,
      this.backdropPath,
      this.runtime})
      : super(
            id: id,
            image: image,
            mediaType: mediaType,
            name: name,
            overview: overview);

  factory Movie.fromJson(Map<String, dynamic> json) {
    final model = ModelDetails.fromJsonBase(json);
    return Movie(
        id: model.id,
        mediaType: model.mediaType,
        name: json["title"],
        releaseDate: json["release_date"],
        overview: model.overview,
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
