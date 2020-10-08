import 'package:flutter/material.dart';
import 'package:onlyfilms/landing_page.dart';
import 'package:onlyfilms/utilities/theme.dart';

void main() => runApp(OnlyFilms());

class OnlyFilms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "OnlyFilms", theme: darkTheme, home: LandingPage());
  }
}
