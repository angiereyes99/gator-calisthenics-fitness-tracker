import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/favorites_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/goals_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/profile_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/running_tracker_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/workouts_page.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';

class MainNavigation extends StatefulWidget {
  static final String id = 'profile_page';

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    ProfilePage(),
    WorkoutsPage(),
    GoalsPage(),
    FavoritesPage(),
    RunningTrackerPage()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryBackground,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.home,
                color: cardColor,
              ),
              title: new Text(
                'Home',
                style: TextStyle(color: primaryBackgroundLight),
              )),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.directions_run,
                color: cardColor,
              ),
              title: new Text(
                'Workouts',
                style: TextStyle(color: primaryBackgroundLight),
              )),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.bookmark,
                color: cardColor,
              ),
              title: new Text(
                'Goals',
                style: TextStyle(color: primaryBackgroundLight),
              )),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.star,
                color: cardColor,
              ), 
              title: new Text(
                'Favorites',
                style: TextStyle(
                  color: primaryBackgroundLight
                ),
              )),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.timelapse,
                color: cardColor,
              ), 
              title: new Text(
                'Tracker',
                style: TextStyle(
                  color: primaryBackgroundLight
                ),
              )),
        ],
        onTap: onTappedBar,
      ),
    );
  }
}
