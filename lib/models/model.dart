import 'package:flutter/material.dart';
import 'package:onlyfilms/models/movie.dart';
import 'package:onlyfilms/models/person.dart';
import 'package:onlyfilms/models/tv.dart';
import 'package:onlyfilms/utilities/localization.dart';

final imagePathTemplate = "https://image.tmdb.org/t/p/w500/";
final movieType = "movie";
final tvType = "tv";
final personType = "person";

class Model {
  final int id;
  final String mediaType;
  final String image;
  final String title;

  Model({this.id, this.mediaType, this.image, this.title});

  factory Model.fromJsonBase(Map<String, dynamic> json) {
    return Model(id: json["id"], mediaType: json["media_type"]);
  }

  factory Model.fromJson(Map<String, dynamic> json, MediaType mediaType) {
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

enum MediaType { multi, person, movie, tv }

extension QueryTypeExtension on MediaType {
  String get url {
    switch (this) {
      case MediaType.multi:
        return "multi";
      case MediaType.person:
        return "person";
      case MediaType.movie:
        return "movie";
      case MediaType.tv:
        return "tv";
      default:
        return null;
    }
  }
}

MediaType getMediaTypeFromText(String mediaType) {
  if (mediaType == MediaType.multi.url) {
    return MediaType.multi;
  } else if (mediaType == MediaType.person.url) {
    return MediaType.person;
  } else if (mediaType == MediaType.movie.url) {
    return MediaType.movie;
  } else if (mediaType == MediaType.tv.url) {
    return MediaType.tv;
  }

  return null;
}

String getMediaTypeName(MediaType type, BuildContext context) {
  switch (type) {
    case MediaType.multi:
      return AppLocalizations.of(context).translate("Multi");
    case MediaType.person:
      return AppLocalizations.of(context).translate("People");
    case MediaType.movie:
      return AppLocalizations.of(context).translate("Movies");
    case MediaType.tv:
      return AppLocalizations.of(context).translate("Tv Series");
    default:
      return null;
  }
}
