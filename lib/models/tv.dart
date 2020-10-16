import 'package:onlyfilms/models/genre.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';
import 'package:onlyfilms/models/person.dart';
import 'package:onlyfilms/models/season.dart';

class Tv extends ModelDetails {
  final String releaseDate;
  final List<Person> createdBy;
  final String status;
  final int voteCount;
  final List<int> episodeRuntime;
  final int numberOfSeasons;
  final List<Season> seasons;

  Tv(
      {id,
      name,
      mediaType,
      this.releaseDate,
      image,
      this.createdBy,
      overview,
      this.status,
      voteAverage,
      this.voteCount,
      genres,
      backdropPath,
      this.episodeRuntime,
      this.numberOfSeasons,
      this.seasons})
      : super(
            id: id,
            name: name,
            image: image,
            mediaType: mediaType,
            overview: overview,
            genres: genres,
            backdropPath: backdropPath,
            voteAverage: voteAverage);

  factory Tv.fromJson(Map<String, dynamic> json) {
    final model = ModelDetails.fromJsonBase(json);
    return Tv(
        id: model.id,
        mediaType: MediaType.tv,
        name: json["name"],
        releaseDate: json["first_air_date"],
        createdBy: Person.getPeopleFromJsonArray(json["created_by"]),
        overview: json["overview"],
        status: json["status"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        genres: Genre.getGenresFromJsonArray(json["genres"]),
        backdropPath: Model.getImageUrl(json["backdrop_path"]),
        episodeRuntime: json["episode_run_time"] != null
            ? List<int>.from(json["episode_run_time"])
            : null,
        image: Model.getImageUrl(json["poster_path"]),
        numberOfSeasons: json["number_of_seasons"],
        seasons: Season.getSeasonsFromJsonArray(json["seasons"]));
  }
}
