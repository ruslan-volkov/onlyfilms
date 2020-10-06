class Genre {
  final int id;
  final String name;

  Genre(this.id, this.name);

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(json["id"], json["name"]);
  }
}
