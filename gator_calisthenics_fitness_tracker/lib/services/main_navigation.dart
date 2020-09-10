import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/favorites_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/goals_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/profile_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/workouts_page.dart';


class MainNavigation extends StatefulWidget {

  static final String id = 'profile_page';

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  int _currentIndex = 0;
  final List<Widget> _pages = [ProfilePage(), WorkoutsPage(), GoalsPage(), FavoritesPage()];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        onTap: onTappedBar,
        color: Colors.green[800],
        items: [
          Icon(Icons.home, size: 30,),
          Icon(Icons.directions_run, size: 30),
          Icon(Icons.bookmark, size:30),
          Icon(Icons.star, size: 30,),
        ],
        backgroundColor: Colors.green[200],
      ),
    );
  }
}