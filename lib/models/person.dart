import 'package:onlyfilms/models/model.dart';

class Person extends Model {
  final String releaseDate;

  Person({id, title, mediaType, this.releaseDate, image})
      : super(id: id, title: title, image: image, mediaType: mediaType);

  factory Person.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJsonBase(json);
    return Person(
        id: model.id,
        mediaType: model.mediaType,
        title: json["name"],
        image: json["profile_path"] != null
            ? imagePathTemplate + json["profile_path"]
            : "");
  }
}
