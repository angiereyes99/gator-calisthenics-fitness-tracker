import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/models/workouts_model.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/profile_page.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';
import 'package:intl/intl.dart';


final collection = FirebaseFirestore.instance.collection('running_times');
final FirebaseAuth auth = FirebaseAuth.instance;

String formattedDate = DateFormat('MM-dd-yyyy HH:mm').format(DateTime.now());


class RunningTrackerPage extends StatefulWidget {
  static final String id = 'running_tracker_id';

  @override
  _RunningTrackerStatePage createState() => _RunningTrackerStatePage();
}

class _RunningTrackerStatePage extends State<RunningTrackerPage> {

  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;
  bool hasSavedTime = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);
    String savedTime = hours.toString().padLeft(2, '0') +
        ":" +
        minutes.toString().padLeft(2, '0') +
        ":" +
        seconds.toString().padLeft(2, '0');
  
    return new Scaffold(
      backgroundColor: isDarkMode ? primaryBackground : primaryBackgroundLight,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? primaryBackground : primaryBackgroundLight,
        elevation: 0.0,
        title: new Text(
          'Running Tracker',
          style: TextStyle(
              color: isDarkMode ? primaryBackgroundLight : primaryBackground),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LabelText(
                  label: 'HRS',
                  value: hours.toString().padLeft(2, '0'),
                ),
                LabelText(
                    label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                LabelText(
                    label: 'SEC', value: seconds.toString().padLeft(2, '0')),
              ],
            ),
            SizedBox(height: 40),
            Wrap(
              children: <Widget>[
                RaisedButton(
                  color: !isActive ? Colors.green : Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Text(isActive ? 'STOP' : 'START'),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Text('RESET'),
                  onPressed: () {
                    setState(() {
                      isActive = false;
                      secondsPassed = 0;
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Text('Finish'),
                  onPressed: isActive
                      ? () {
                          setState(() {
                            hasSavedTime = true;
                            isActive = !isActive;
                            collection.add({
                              "email": auth.currentUser.email,
                              "duration": savedTime,
                              'has_completed': false,
                              'datetime': formattedDate,
                            });
                          });
                        }
                      : null,
                ),
              ],
            ),
            SavedTimesStream(),
          ],
        ),
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: primaryTextColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class SavedTimesStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot> (
      stream: collection
              .where('email', isEqualTo: auth.currentUser.email)
              //.orderBy('datetime', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: primaryBackground,
            ),
          );
        }

        final durations = snapshot.data.docs;
        List<DurationCard> durationCards = [];

        for (var duration in durations) {
          final dur = duration['duration'];
          final date = duration['datetime'];

          final durationCard = DurationCard(
            duration: dur,
            datetime: date,
          );
          durationCards.add(durationCard);
          WorkoutsModel.workouts.add('Run: $date \n  Duration: $dur');
        }

        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: durationCards,
          ),
        );
      },
    );
  }
}

class DurationCard extends StatelessWidget {

  DurationCard({this.duration, this.datetime});

  final String duration;
  final String datetime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 25,
            color: primaryBackgroundLight,
            child: ListTile(
              title: Text(
                'Saved Running Time: $duration',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: font,
                ),
              ),
              subtitle: Text(
                'Saved on: $datetime',
                style: TextStyle(
                  fontFamily: font
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}