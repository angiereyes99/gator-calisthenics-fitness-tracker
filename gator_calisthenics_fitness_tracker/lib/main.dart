import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/about_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/favorites_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/goals_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/login_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/profile_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/running_tracker_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/workouts_page.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';


void main() => runApp(GatorCalisthenics());

class GatorCalisthenics extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        scaffoldBackgroundColor: Colors.black, 
        unselectedWidgetColor: primaryBackground,
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        ProfilePage.id: (context) => ProfilePage(),
        WorkoutsPage.id: (context) => WorkoutsPage(),
        GoalsPage.id: (context) => GoalsPage(),
        FavoritesPage.id: (context) => FavoritesPage(),
        RunningTrackerPage.id: (context) => RunningTrackerPage(),
        AboutPage.id: (context) => AboutPage(),
      },
    );
  }
}