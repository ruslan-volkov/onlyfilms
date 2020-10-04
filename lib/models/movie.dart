import 'package:onlyfilms/models/model.dart';

class Movie extends Model {
  final String releaseDate;

  Movie({id, mediaType, title, this.releaseDate, image})
      : super(id: id, image: image, mediaType: mediaType, title: title);

  factory Movie.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJsonBase(json);
    return Movie(
        id: model.id,
        mediaType: model.mediaType,
        title: json["title"],
        releaseDate: json["releaseDate"],
        image: json["poster_path"] != null
            ? imagePathTemplate + json["poster_path"]
            : "");
  }
}
