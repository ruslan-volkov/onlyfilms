import 'package:onlyfilms/models/model.dart';

class Person extends Model {
  final String releaseDate;
  final String biography;
  final String birthday;
  final String deathday;
  final String knownForDepartment;

  Person(
      {id,
      title,
      mediaType,
      this.releaseDate,
      image,
      this.biography,
      this.birthday,
      this.deathday,
      this.knownForDepartment})
      : super(id: id, title: title, image: image, mediaType: mediaType);

  factory Person.fromJson(Map<String, dynamic> json) {
    final model = Model.fromJsonBase(json);
    return Person(
        id: model.id,
        mediaType: model.mediaType,
        title: json["name"],
        biography: json["biography"],
        birthday: json["birthday"],
        deathday: json["deathday"],
        knownForDepartment: json["known_for_department"],
        image: Model.getImageUrl(json["profile_path"]));
  }

  static List<Person> getPeopleFromJsonArray(dynamic json) {
    List<Person> ppl = new List<Person>();
    for (var person in json) {
      ppl.add(Person.fromJson(person));
    }
    return ppl;
  }
}
