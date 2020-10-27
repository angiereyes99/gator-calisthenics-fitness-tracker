import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';


class RunningTrackerPage extends StatefulWidget {

  static final String id = 'running_tracker_id';

  @override
  _RunningTrackerStatePage createState() => _RunningTrackerStatePage();
}

class _RunningTrackerStatePage extends State<RunningTrackerPage> {

  bool flag = true;
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;    
  // String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';

  Stream<int> stopwatchStream() {

  StreamController<int> streamController;
  Timer timer;
  Duration timerInterval = Duration(seconds: 1);
  int counter = 0;

  void stopTimer() {

    if (timer != null) {
      timer.cancel();
      timer = null;
      counter = 0;
      streamController.close();
    }
  }

  void tick(_) {
    counter++;
    streamController.add(counter);
    if (!flag) {
      streamController.close();
    }
  }

  void startTimer() {
    timer = Timer.periodic(timerInterval, tick);
  }

  streamController = StreamController<int>(
    onListen: startTimer,
    onCancel: stopTimer,
    onResume: startTimer,
    onPause: stopTimer,
  );

  return streamController.stream;
}

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
                "$minutesStr:$secondsStr",
                style: TextStyle(
                  fontSize: 70.0,
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
                          // hoursStr = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
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
                  ),
                  SizedBox(width: 40.0),
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    onPressed: () {
                      timerSubscription.cancel();
                      timerStream = null;
                      setState(() {
                        // hoursStr = '00';
                        minutesStr = '00';
                        secondsStr = '00';
                      });
                    },
                    color: Colors.red,
                    child: Text(
                      'RESET',
                      style: TextStyle(
                        color: Colors.white,
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