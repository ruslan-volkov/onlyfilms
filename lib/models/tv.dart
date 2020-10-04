import 'package:onlyfilms/models/model.dart';

class Tv extends Model {
  final String releaseDate;

  Tv({id, title, mediaType, this.releaseDate, image})
      : super(id: id, title: title, image: image, mediaType: mediaType);

  factory Tv.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJsonBase(json);
    return Tv(
        id: model.id,
        mediaType: model.mediaType,
        title: json["name"],
        releaseDate: json["first_air_date"],
        image: json["poster_path"] != null
            ? imagePathTemplate + json["poster_path"]
            : "");
  }
}
