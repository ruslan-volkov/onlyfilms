import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:onlyfilms/models/genre.dart';
import 'package:onlyfilms/models/image_api.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';
import 'package:onlyfilms/models/season.dart';

// TODO : get api key from flutter db
final String apiKey = "api_key=596add70d5379735ac76cac1ac83c4b0";
final String langUS = "language=en-US";
final String url = "https://api.themoviedb.org/3/";
String lang;

enum HomeCategoryType {
  popular,
  top_rated,
  upcoming,
  now_playing,
  airing_today,
  on_the_air
}

void initLang(Locale locale) {
  lang = '${locale.languageCode}-${locale.countryCode}';
}

class GenresApi {
  static List<Genre> tvGenres = [];
  static List<Genre> movieGenres = [];
  static final GenresApi _singleton = GenresApi._internal();
  static Future<bool> setGenres() async {
    movieGenres = await getGenres(MediaType.movie);
    tvGenres = await getGenres(MediaType.tv);
    return true;
  }

  factory GenresApi() {
    return _singleton;
  }

  GenresApi._internal();
}

extension QueryTypeExtension on HomeCategoryType {
  String get url {
    switch (this) {
      case HomeCategoryType.popular:
        return "popular";
      case HomeCategoryType.top_rated:
        return "top_rated";
      case HomeCategoryType.upcoming:
        return "upcoming";
      case HomeCategoryType.now_playing:
        return "now_playing";
      case HomeCategoryType.airing_today:
        return "airing_today";
      case HomeCategoryType.on_the_air:
        return "on_the_air";
      default:
        return null;
    }
  }
}

Future<List<Model>> fetchAll(
    {MediaType type = MediaType.multi, String query, int page = 1}) async {
  List<Model> result = [];
  if (query.isNotEmpty) {
    final response = await http.get(
        '${url}search/${type.url}?$apiKey&language=$lang&page=${page.toString()}&query=$query');
    if (response.statusCode == 200) {
      for (final e in json.decode(response.body)["results"]) {
        result.add(Model.fromJson(e, type));
      }
      return result;
    } else {
      throw Exception("Failed to load");
    }
  } else {
    return result;
  }
}

Future<ModelDetails> getDetails({MediaType type, int id}) async {
  if (!id.isNaN) {
    final response = await http
        .get('$url${type.url}/${id.toString()}?$apiKey&language=$lang');
    if (response.statusCode == 200) {
      return ModelDetails.fromJson(json.decode(response.body), type);
    } else {
      throw Exception("Failed to load");
    }
  } else {
    throw Exception("Id should be a number");
  }
}

Future<List<ImageApi>> getImages({MediaType type, int id}) async {
  if (!id.isNaN) {
    final response =
        await http.get('$url${type.url}/${id.toString()}/images?$apiKey');
    if (response.statusCode == 200) {
      List<ImageApi> result = [];
      var body = json.decode(response.body);
      result = ImageApi.getFromJsonByType(type, body);
      return result;
    } else {
      throw Exception("Failed to load");
    }
  } else {
    throw Exception("Id should be a number");
  }
}

Future<List<Model>> getCast({MediaType type, int id}) async {
  if (!id.isNaN) {
    final response = await http.get(
        '$url${type.url}/${id.toString()}/${type == MediaType.person ? 'combined_credits' : 'credits'}?$apiKey&language=$lang');
    if (response.statusCode == 200) {
      List<Model> result = [];
      for (final e in json.decode(response.body)["cast"]) {
        if (type == MediaType.person) {
          result.add(Model.fromJson(e, MediaType.movie));
        } else {
          result.add(Model.fromJson(e, MediaType.person));
        }
      }
      return result;
    } else {
      throw Exception("Failed to load");
    }
  } else {
    throw Exception("Id should be a number");
  }
}

Future<List<Model>> getHomeCategoryItems(
    {MediaType type, HomeCategoryType category, int page = 1}) async {
  final response = await http
      .get('$url${type.url}/${category.url}?$apiKey&language=$lang&page=$page');
  if (response.statusCode == 200) {
    List<Model> result = [];
    for (final e in json.decode(response.body)["results"]) {
      result.add(Model.fromJson(e, type));
    }
    return result;
  } else {
    throw Exception("Failed to load");
  }
}

Future<List<Season>> getSeasons({int tvId, int numberOfSeasons = 1}) async {
  List<Season> seasons = [];
  List<Future> futures = [];
  for (var i = 1; i <= numberOfSeasons; i++) {
    futures.add(http
        .get('$url${MediaType.tv.url}/$tvId/season/$i?$apiKey&language=$lang')
        .then((response) => {
              if (response.statusCode == 200)
                {seasons.add(Season.fromJson(json.decode(response.body)))}
              else
                {throw Exception("Failed to load")}
            }));
  }
  await Future.wait(futures);
  seasons.sort((a, b) => a.seasonNumber.compareTo(b.seasonNumber));
  return seasons;
}

Future<List<Genre>> getGenres(MediaType type) async {
  final response =
      await http.get('${url}genre/${type.url}/list?$apiKey&language=$lang');
  if (response.statusCode == 200) {
    List<Genre> result = [];
    for (final e in json.decode(response.body)["genres"]) {
      result.add(Genre.fromJson(e));
    }
    return result;
  } else {
    throw Exception("Failed to load");
  }
}
