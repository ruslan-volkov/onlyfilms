import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlyfilms/screens/calendar/calendar.dart';
import 'package:onlyfilms/screens/home/home.dart';
import 'package:onlyfilms/screens/settings/account.dart';

import 'constants.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case homeRoute:
        builder = (BuildContext context) => Home();
        break;
      case accountRoute:
        builder = (BuildContext context) => Account();
        break;
      case calendarRoute:
        builder = (BuildContext context) => Calendar();
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
