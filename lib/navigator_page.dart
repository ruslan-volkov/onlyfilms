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
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        selectedItemColor: Theme.of(context).selectedRowColor,
        currentIndex: _currentIndex,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.perm_identity_sharp),
            label: AppLocalizations.of(context).translate("Account"),
            backgroundColor: Theme.of(context).bottomAppBarColor,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie_sharp),
            label: AppLocalizations.of(context).translate("Home"),
            backgroundColor: Theme.of(context).bottomAppBarColor,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search_sharp),
            label: AppLocalizations.of(context).translate("Search"),
            backgroundColor: Theme.of(context).bottomAppBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_sharp),
            label: AppLocalizations.of(context).translate("Calendar"),
            backgroundColor: Theme.of(context).bottomAppBarColor,
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
