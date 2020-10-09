import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:onlyfilms/models/cast.dart';
import 'package:onlyfilms/models/image_api.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/models/model_details.dart';

// TODO : get api key from flutter db
final String apiKey = "api_key=596add70d5379735ac76cac1ac83c4b0";
final String langUS = "language=en-US";
final String url = "https://api.themoviedb.org/3/";

Future<List<Model>> fetchAll(
    {MediaType type = MediaType.multi, String query, int page}) async {
  List<Model> result = new List<Model>();
  if (query.isNotEmpty) {
    final response = await http.get(
        '${url}search/${type.url}?$apiKey&$langUS&page=${page.toString()}&query=$query');
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
    final response = await http.get('$url${type.url}/${id.toString()}?$apiKey');
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
      List<ImageApi> result = new List<ImageApi>();
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

Future<List<Cast>> getCast({MediaType type, int id}) async {
  if (!id.isNaN) {
    final response =
        await http.get('$url${type.url}/${id.toString()}/credits?$apiKey');
    if (response.statusCode == 200) {
      List<Cast> result = new List<Cast>();
      for (final e in json.decode(response.body)["cast"]) {
        result.add(Cast.fromJson(e, type));
      }
      return result;
    } else {
      throw Exception("Failed to load");
    }
  } else {
    throw Exception("Id should be a number");
  }
}
