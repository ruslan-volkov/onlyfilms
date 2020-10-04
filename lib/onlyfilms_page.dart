import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlyfilms/landing_page.dart';

void main() => runApp(OnlyFilms());

class OnlyFilms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xFF2A6A71)));
    return MaterialApp(
        title: 'OnlyFilms',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingPage());
  }
}
