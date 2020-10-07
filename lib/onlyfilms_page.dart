import 'package:flutter/material.dart';
import 'package:onlyfilms/landing_page.dart';

void main() => runApp(OnlyFilms());

class OnlyFilms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "OnlyFilms",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingPage());
  }
}
