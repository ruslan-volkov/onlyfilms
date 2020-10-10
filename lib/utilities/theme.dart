import 'package:flutter/material.dart';

const Color darkAppBarColor = Color(0xFF2D3047);

var darkTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: Color(0xFF4487c7),
    backgroundColor: Color(0xFF383B57),
    bottomAppBarColor: darkAppBarColor,
    selectedRowColor: Color(0xFFF47263),
    // unselectedWidgetColor: Color(0xFF1B998B),
    primaryColorDark: Color(0xFF585C89),
    primaryColor: Color(0xFF2A6A71),
    primaryColorLight: Color(0xFF1B998B),
    textSelectionColor: Color(0xFF383B57),
    splashColor: Color(0xFFF47263),
    highlightColor: Color(0xFFff9b70),
    unselectedWidgetColor: Colors.blueGrey,
    textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white),
        caption: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white70),
        bodyText1: TextStyle(color: Color(0xFFFFFEAD), fontSize: 20)));
