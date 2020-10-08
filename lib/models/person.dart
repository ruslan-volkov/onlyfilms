import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';

class Person extends ModelDetails {
  final String releaseDate;
  final String birthday;
  final String deathday;
  final String knownForDepartment;

  Person(
      {id,
      name,
      mediaType,
      this.releaseDate,
      image,
      overview,
      this.birthday,
      this.deathday,
      this.knownForDepartment})
      : super(
            id: id,
            name: name,
            image: image,
            mediaType: mediaType,
            overview: overview);

  factory Person.fromJson(Map<String, dynamic> json) {
    final model = ModelDetails.fromJsonBase(json);
    return Person(
        id: model.id,
        mediaType: model.mediaType,
        name: json["name"],
        overview: model.overview,
        birthday: json["birthday"],
        deathday: json["deathday"],
        knownForDepartment: json["known_for_department"],
        image: Model.getImageUrl(json["profile_path"]));
  }

  static List<Person> getPeopleFromJsonArray(dynamic json) {
    List<Person> ppl = new List<Person>();
    if (json != null) {
      for (var person in json) {
        ppl.add(Person.fromJson(person));
      }
    }
    return ppl;
  }
}
