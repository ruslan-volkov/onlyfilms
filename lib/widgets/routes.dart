import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlyfilms/screens/auth/login_page.dart';
import 'package:onlyfilms/screens/calendar/calendar_page.dart';
import 'package:onlyfilms/screens/home/home_page.dart';
import 'package:onlyfilms/screens/search/search_page.dart';
import 'package:onlyfilms/screens/settings/account_page.dart';

import '../utilities/constants.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case homeRoute:
        builder = (BuildContext context) => HomePage();
        break;
      case accountRoute:
        builder = (BuildContext context) => AccountPage();
        break;
      case calendarRoute:
        builder = (BuildContext context) => CalendarPage();
        break;
      case loginRoute:
        builder = (BuildContext context) => LoginPage();
        break;
      case searchRoute:
        builder = (BuildContext context) => SearchPage();
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
