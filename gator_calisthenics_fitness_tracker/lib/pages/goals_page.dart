import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';


class GoalsPage extends StatefulWidget {

  static final String id = 'goals_page';

  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: primaryBackground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('This is for Goals page')
            ],
          ),
        ),
      ),
    );
  }
}