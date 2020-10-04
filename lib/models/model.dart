import 'package:onlyfilms/models/movie.dart';
import 'package:onlyfilms/models/person.dart';
import 'package:onlyfilms/models/tv.dart';

final imagePathTemplate = "https://image.tmdb.org/t/p/w500/";
final movieType = "movie";
final tvType = "tv";
final personType = "person";

class Model {
  final int id;
  final String mediaType;
  final String image;
  final String title;

  Model({this.id, this.mediaType, this.image, this.title});

  factory Model.fromJsonBase(Map<String, dynamic> json) {
    return Model(id: json["id"], mediaType: json["media_type"]);
  }

  factory Model.fromJson(Map<String, dynamic> json) {
    final String mediaType = json["media_type"];
    if (mediaType == movieType) {
      return Movie.fromJson(json);
    } else if (mediaType == tvType) {
      return Tv.fromJson(json);
    } else if (mediaType == personType) {
      return Person.fromJson(json);
    } else {
      return Model.fromJsonBase(json);
    }
  }
}
