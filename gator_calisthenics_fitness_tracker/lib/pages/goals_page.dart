import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/models/workouts_model.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/profile_page.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';
import 'package:intl/intl.dart';

class GoalsPage extends StatefulWidget {
  static final String id = 'goals_page';

  @override
  createState() => new GoalsPageState();
}

class GoalsPageState extends State<GoalsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final collection = FirebaseFirestore.instance.collection('todos');

  List<String> _todoItems = [];
  bool test = false;

  String formattedDate = DateFormat('MM-dd-yyyy HH:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: isDarkMode ? primaryBackground : primaryBackgroundLight,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? Colors.black : primaryBackgroundLight,
        elevation: 0,
        title: new Text(
          'Set Your Goals Here!',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(32.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: collection.where('email', isEqualTo: auth.currentUser.email).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 15,
                            color: isDarkMode ? primaryTextColor : Colors.white,
                            child: CheckboxListTile(
                              checkColor: Colors.black,
                              title: Text(
                                document['todo_item'],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                  "Goal created on: " + document["datetime"]),
                              value: document['has_completed'],
                              onChanged: (newValue) {
                                collection
                                    .doc(document.id)
                                    .update({'has_completed': newValue});
                                if (document['has_completed'] == true) {
                                  collection.doc(document.id).delete();
                                }
                              },
                            ));
                      }).toList(),
                    );
                }
              },
            )),
      ),
      floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            _pushAddTodoScreen();
          },
          tooltip: 'Add task',
          child: new Icon(
            Icons.bookmark,
            color: Colors.black,
          )),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(
              backgroundColor: Colors.green[800],
              title: new Text('Add a new goal')),
          body: new TextField(
            autofocus: true,
            style: TextStyle(color: Colors.white),
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context);
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  void _addTodoItem(String task) {
    if (task.length > 0) {
      collection.add({
        "email": auth.currentUser.email,
        "todo_item": task,
        "has_completed": false,
        "is_me": true,
        "datetime": formattedDate,
      }).then((value) {
        print(value.id);
      });
      collection.orderBy('date', descending: true);
      setState(() => _todoItems.add(task));
    }
  }

  bool confirmCompletedDialogue(bool test) {
    Widget confirmButton = FlatButton(
      child: Text('Achieved!'),
      onPressed: () {
        test = true;
        print(test);
        Navigator.pop(context);
      },
    );

    Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        test = false;
        print(test);
        Navigator.pop(context);
      },
    );

    AlertDialog confirm = AlertDialog(
      title: Text('Did you achieve this goal?'),
      content:
          Text('Setting goals is the best way to keep yourself accountable!'),
      actions: [confirmButton, cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return confirm;
      },
    );

    return test;
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}