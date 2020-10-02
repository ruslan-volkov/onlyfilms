import 'package:flutter/material.dart';
import 'package:onlyfilms/widgets/routes.dart';

import 'constants/constants.dart';

class FirstScreen extends StatefulWidget {
  @override
  State createState() {
    return new FirstScreenState();
  }
}

class FirstScreenState extends State<FirstScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (settings) => Routes.generateRoute(settings),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.perm_identity_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            label: "",
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
