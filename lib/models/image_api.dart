import 'package:onlyfilms/models/model.dart';

class ImageApi {
  final num aspectRatio;
  final String filePath;
  final int height;
  final int width;
  ImageApi({this.aspectRatio, this.filePath, this.height, this.width});

  factory ImageApi.fromJson(Map<String, dynamic> json) {
    return ImageApi(
        aspectRatio: json["aspect_ratio"],
        filePath: Model.getImageUrl(json["file_path"]),
        height: json["height"],
        width: json["width"]);
  }

  static List<ImageApi> getFromJsonByType(
      MediaType type, Map<String, dynamic> json) {
    List<ImageApi> result = new List<ImageApi>();

    if (type == MediaType.person) {
      for (final e in json["profiles"]) {
        result.add(ImageApi.fromJson(e));
      }
    } else if (type == MediaType.movie || type == MediaType.tv) {
      for (final e in json["backdrops"]) {
        result.add(ImageApi.fromJson(e));
      }
      for (final e in json["posters"]) {
        result.add(ImageApi.fromJson(e));
      }
    }
    return result;
  }
}
