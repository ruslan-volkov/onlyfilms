import 'package:flutter/material.dart';
import 'package:onlyfilms/widgets/routes.dart';

import 'utilities/constants.dart';

class NavigatorPage extends StatefulWidget {
  @override
  State createState() {
    return new NavigatorPageState();
  }
}

class NavigatorPageState extends State<NavigatorPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: homeRoute,
        onGenerateRoute: (settings) => Routes.generateRoute(settings),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.perm_identity_outlined),
            label: "Account",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            label: "Calendar",
          )
        ],
        onTap: (int index) {
          if (index != _currentIndex) {
            switch (index) {
              case 0:
                _navigatorKey.currentState.pushNamed(accountRoute);
                break;
              case 1:
                _navigatorKey.currentState.pushNamed(homeRoute);
                break;
              case 2:
                _navigatorKey.currentState.pushNamed(calendarRoute);
                break;
              default:
            }
          }
          setState(() => _currentIndex = index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
