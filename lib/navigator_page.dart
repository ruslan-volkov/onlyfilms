import 'package:flutter/material.dart';
import 'package:onlyfilms/screens/calendar/calendar_page.dart';
import 'package:onlyfilms/screens/home/home_page.dart';
import 'package:onlyfilms/screens/search/search_page.dart';
import 'package:onlyfilms/screens/settings/account_page.dart';
import 'package:onlyfilms/utilities/localization.dart';

class NavigatorPage extends StatefulWidget {
  @override
  State createState() {
    return new NavigatorPageState();
  }
}

class NavigatorPageState extends State<NavigatorPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: IndexedStack(
        children: <Widget>[
          AccountPage(),
          HomePage(),
          SearchPage(),
          CalendarPage(),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).splashColor,
        selectedItemColor: Theme.of(context).highlightColor,
        currentIndex: _currentIndex,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.perm_identity_sharp),
            label: AppLocalizations.of(context).translate("Account"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie_creation_outlined),
            label: AppLocalizations.of(context).translate("Home"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search_sharp),
            label: AppLocalizations.of(context).translate("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: AppLocalizations.of(context).translate("Calendar"),
          )
        ],
        onTap: (int index) {
          setState(() => _currentIndex = index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
