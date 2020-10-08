import 'package:flutter/material.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/movie.dart';
import 'package:onlyfilms/models/person.dart';
import 'package:onlyfilms/models/tv.dart';
import 'package:onlyfilms/utilities/localization.dart';

class ModelDetails extends Model {
  final String overview;
  ModelDetails({id, mediaType, image, name, this.overview})
      : super(id: id, image: image, mediaType: mediaType, name: name);

  factory ModelDetails.fromJsonBase(Map<String, dynamic> json) {
    final model = Model.fromJsonBase(json);
    return ModelDetails(id: model.id, mediaType: model.mediaType);
  }

  factory ModelDetails.fromJson(
      Map<String, dynamic> json, MediaType mediaType) {
    var mediaTypeFromApi = json["media_type"];
    if (mediaTypeFromApi != null && mediaTypeFromApi.toString().isNotEmpty) {
      mediaType = getMediaTypeFromText(mediaTypeFromApi);
    }
    if (mediaType == MediaType.movie) {
      return Movie.fromJson(json);
    } else if (mediaType == MediaType.tv) {
      return Tv.fromJson(json);
    } else if (mediaType == MediaType.person) {
      return Person.fromJson(json);
    } else {
      return Model.fromJsonBase(json);
    }
  }
}
