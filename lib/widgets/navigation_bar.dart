import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  @override
  State createState() {
    return new NavigationBarState();
  }
}

class NavigationBarState extends State<NavigationBar> {
  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0, // this will be set when a new tab is tapped
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
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
