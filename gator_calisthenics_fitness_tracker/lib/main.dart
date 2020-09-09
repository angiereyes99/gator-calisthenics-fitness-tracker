import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/login_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/profile_page.dart';


void main() => runApp(GatorCalisthenics());

class GatorCalisthenics extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        ProfilePage.id: (context) => ProfilePage(),
      },
    );
  }
}