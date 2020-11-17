import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/profile_page.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkoutsPage extends StatefulWidget {
  static final String id = 'workouts_page';

  @override
  _WorkoutsPageState createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  bool test = false;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundLight,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryBackgroundLight,
        elevation: 0,
        title: new Text(
          'Keep track of your workouts!',
          style: TextStyle(
            color: primaryBackground,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events, _) {
                setState(() {
                  print(date);
                  print(events);
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            SizedBox(height: 20,),
            ..._selectedEvents.map((event) => Card(
              color: primaryTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 10,
              child: CheckboxListTile(
                onChanged: (newValue) {
                  print('lol');
                  test = true;
                  if (test == true) {
                    _events.remove(event);
                  }
                  print(event);
                },
                checkColor: primaryBackground,
                value: test,
                title: Text(event),
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddDialog();
          _events.remove('Bench Press');
        }//_showAddDialog,
      ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add workout?'),
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    if (_events[_controller.selectedDay] != null) {
                      _events[_controller.selectedDay]
                          .add(_eventController.text);
                    } else {
                      _events[_controller.selectedDay] = [
                        _eventController.text
                      ];
                    }
                    prefs.setString("events", json.encode(encodeMap(_events)));
                    _eventController.clear();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
  }
}