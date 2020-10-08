import 'package:onlyfilms/models/genre.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/person.dart';

class Tv extends Model {
  final String releaseDate;
  final List<Person> createdBy;
  final String overview;
  final String status;
  final num voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final String backdropPath;
  final List<int> episodeRuntime;

  Tv(
      {id,
      title,
      mediaType,
      this.releaseDate,
      image,
      this.createdBy,
      this.overview,
      this.status,
      this.voteAverage,
      this.voteCount,
      this.genres,
      this.backdropPath,
      this.episodeRuntime})
      : super(id: id, title: title, image: image, mediaType: mediaType);

  factory Tv.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJsonBase(json);
    return Tv(
        id: model.id,
        mediaType: model.mediaType,
        title: json["name"],
        releaseDate: json["first_air_date"],
        createdBy: Person.getPeopleFromJsonArray(json["created_by"]),
        overview: json["overview"],
        status: json["status"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        genres: Genre.getGenresFromJsonArray(json["genres"]),
        backdropPath: Model.getImageUrl(json["backdrop_path"]),
        episodeRuntime: json["episode_run_time"],
        image: Model.getImageUrl(json["poster_path"]));
  }
}
