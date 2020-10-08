import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onlyfilms/landing_page.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/utilities/theme.dart';

void main() => runApp(OnlyFilms());

class OnlyFilms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(localizationsDelegates: [
      // ... app-specific localization delegate[s] here
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ], supportedLocales: [
      const Locale("en", ""),
      const Locale("fr", ""),
    ], title: "OnlyFilms", theme: darkTheme, home: LandingPage());
  }
}
