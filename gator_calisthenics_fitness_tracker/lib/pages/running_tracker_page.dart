import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';


class RunningTrackerPage extends StatefulWidget {

  static final String id = 'running_tracker_id';

  @override
  _RunningTrackerStatePage createState() => _RunningTrackerStatePage();
}

class _RunningTrackerStatePage extends State<RunningTrackerPage> {

  final firestoreInstance = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  //final collection = FirebaseFirestore.instance.collection('todos');

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
    String saved_time = hours.toString().padLeft(2, '0') + 
                      ":" + minutes.toString().padLeft(2, '0') + 
                      ":" + seconds.toString().padLeft(2, '0');

    return new Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: new Text('Running Tracker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 65,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LabelText(
                    label: 'HRS', value: hours.toString().padLeft(2, '0'),),
                LabelText(
                    label: 'MIN',
                    value: minutes.toString().padLeft(2, '0')),
                LabelText(
                    label: 'SEC',
                    value: seconds.toString().padLeft(2, '0')),
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
              SizedBox(width: 10,),
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
              SizedBox(width: 10,),
              RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)),
                child: Text('Finish'),
                onPressed: isActive ? () {
                  setState(() {
                    hasSavedTime = true;
                    isActive = !isActive;
                    firestoreInstance.collection('running_times').add({
                        "email": auth.currentUser.email,
                        "duration": saved_time,
                      });
                    });
                  } : null,
                ),
              ],
            ),
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