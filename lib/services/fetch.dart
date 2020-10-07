import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:onlyfilms/models/model.dart';

// TODO : get api key from flutter db
final String apiKey = "api_key=596add70d5379735ac76cac1ac83c4b0";
final String langUS = "language=en-US";
final String url = "https://api.themoviedb.org/3/";

Future<List<Model>> fetchAll(
    {MediaType type = MediaType.multi, String query, int page}) async {
  List<Model> result = new List<Model>();
  if (query.isNotEmpty) {
    final response = await http.get(url +
        "search/" +
        type.url +
        "?" +
        apiKey +
        "&" +
        langUS +
        "&page=" +
        page.toString() +
        "&query=" +
        query);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (final e in json.decode(response.body)["results"]) {
        result.add(Model.fromJson(e, type));
      }
      return result;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  } else {
    return result;
  }
}

// Future<List<Genre>> getGenres() async {
//   List<Genre> result = new List<Genre>();
//   final response =
//       await http.get(url + "genre/movie/list?" + apiKey + "&" + langUS);
//   if (response.statusCode == 200) {
//     for (final e in json.decode(response.body)["genres"]) {
//       result.add(Genre.fromJson(e));
//     }
//     return result;
//   } else {
//     throw Exception('Failed to load');
//   }
// }
