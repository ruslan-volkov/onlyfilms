import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:onlyfilms/models/model.dart';

final String apiKey = "api_key=596add70d5379735ac76cac1ac83c4b0";
final String langUS = "language=en-US";
final String url = "https://api.themoviedb.org/3/";

Future<List<Model>> fetchAll(String query, int page) async {
  List<Model> result = new List<Model>();
  if (query.isNotEmpty) {
    final response = await http.get(url +
        "search/multi?" +
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
        result.add(Model.fromJson(e));
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
