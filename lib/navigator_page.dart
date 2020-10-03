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
        backgroundColor: Color(0xFF2D3047),
        unselectedItemColor: Color(0xFF1B998B),
        selectedItemColor: Color(0xFFFFFD82),
        // fixedColor: Colors.lightBlue[800],
        currentIndex: _currentIndex,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.perm_identity_sharp),
            label: "Account",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie_sharp),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_sharp),
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
