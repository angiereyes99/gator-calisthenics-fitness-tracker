import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/profile_page.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';

class WorkoutsPage extends StatefulWidget {
  static final String id = 'workouts_page';

  @override
  _WorkoutsPageState createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? primaryBackground : Colors.white,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? primaryBackground : primaryBackgroundLight,
        elevation: 0,
        title: new Text(
          'Keep track of your workouts!',
          style: TextStyle(
            color: isDarkMode ? primaryBackgroundLight : primaryBackground,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'This is for workouts page',
                style: TextStyle(color: primaryTextColor),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: primaryTextColor,
          onPressed: () {
            //print(WorkoutsModel.workouts);
          }, //_pushAddTodoScreen,
          tooltip: 'Add task',
          child: new Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
