import 'package:onlyfilms/models/model.dart';

class Cast extends Model {
  Cast({id, mediaType, image, name})
      : super(id: id, image: image, mediaType: mediaType, name: name);

  factory Cast.fromJson(Map<String, dynamic> json, MediaType mediaType) {
    final model = Model.fromJsonBase(json);
    var image = "";
    if (mediaType == MediaType.movie || mediaType == MediaType.tv) {
      image = json["profile_path"];
    } else if (mediaType == MediaType.person) {
      image = json["poster_path"];
      return Model.fromJson(json, getMediaTypeFromText(json["media_type"]));
    }
    return Cast(
        id: model.id,
        mediaType: mediaType,
        image:
            image != null && image.isNotEmpty ? Model.getImageUrl(image) : "",
        name: json["name"] != null && json["name"] != ""
            ? json["name"]
            : json["title"] != null && json["title"] != ""
                ? json["title"]
                : "");
  }
}
