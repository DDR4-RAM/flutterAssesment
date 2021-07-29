import 'package:flutter/material.dart';
import 'package:flutter_test_project/screens/calendar_components/calendar_page.dart';
import 'package:flutter_test_project/screens/map_components/map_page.dart';
import 'package:flutter_test_project/screens/pokemos_components/pokemon_list.dart';


class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static List<Widget> _screens = <Widget>[
    PokemonList(),
    CalendarPage(),
    MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: "Pokemon",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Calendar",
          ),
          new BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map")
        ],
      ),
    );
  }
}
