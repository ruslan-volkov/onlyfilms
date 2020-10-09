import 'package:onlyfilms/models/genre.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/movie.dart';
import 'package:onlyfilms/models/person.dart';
import 'package:onlyfilms/models/tv.dart';

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
    }
    return Cast(
        id: model.id,
        mediaType: model.mediaType,
        image: image.isNotEmpty ? Model.getImageUrl(image) : "",
        name: model.name);
  }

  // static List<Cast> getFromJsonByType(
  //     MediaType type, Map<String, dynamic> json) {
  //   List<Cast> result = new List<Cast>();
  //   for (final e in json) {
  //     result.add(Cast.fromJson(e, type));
  //   }
  //   return result;
  // }
}
