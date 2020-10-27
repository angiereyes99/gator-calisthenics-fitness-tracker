import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/streams/stopwatch_stream.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';


class RunningTrackerPage extends StatefulWidget {

  static final String id = 'running_tracker_id';

  @override
  _RunningTrackerStatePage createState() => _RunningTrackerStatePage();
}

class _RunningTrackerStatePage extends State<RunningTrackerPage> {

  var timerStream, timerSubscription, hoursStr, minutesStr, secondsStr;

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
              Text(
                "$hoursStr:$minutesStr:$secondsStr",
                style: TextStyle(
                  fontSize: 90.0,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    onPressed: () {
                      timerStream = stopwatchStream();
                      timerSubscription = timerStream.listen((int newTick) {
                        setState(() {
                          hoursStr = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
                          minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
                          secondsStr = (newTick % 60).floor().toString().padLeft(2,'0');
                        });
                      });
                    },
                    color: Colors.green,
                    child: Text(
                      'START',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}