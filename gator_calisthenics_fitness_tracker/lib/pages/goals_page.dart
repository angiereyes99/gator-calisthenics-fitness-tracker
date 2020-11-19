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
  TextEditingController _goalController;

  List<String> _todoItems = [];
  bool test = false;

  String formattedDate = DateFormat('MM-dd-yyyy HH:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: isDarkMode ? primaryBackground : primaryBackgroundLight,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? primaryBackground : primaryBackgroundLight,
        elevation: 0,
        title: new Text(
          'Set Your Fitness Goals Here!',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: 20
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 40.0),
        decoration: BoxDecoration(
          color: Color(0xff0E164C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.lerp(Radius.circular(0), Radius.circular(100), 40),
            topRight: Radius.lerp(Radius.circular(10), Radius.circular(10), 50),
          )
        ),
        child: Center(
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
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft:  Radius.circular(10.0),
                              topRight: Radius.lerp(Radius.circular(30), Radius.circular(30), 6),
                              bottomRight: Radius.lerp(Radius.circular(30), Radius.circular(30), 6),
                            ),
                          ),
                          elevation: 5,
                          color: Color(0xFF607D8B),
                          child: CheckboxListTile(
                            checkColor: Colors.black,
                            title: Text(
                              document['todo_item'],
                              style: TextStyle(
                                color: primaryBackgroundLight,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "Goal created on: " + document["datetime"],
                              style: TextStyle(
                                // fontFamily: font,
                                color: primaryTextColor,
                              ),
                            ),
                            value: document['has_completed'],
                            onChanged: (newValue) {
                              collection
                                  .doc(document.id)
                                  .update({'has_completed': newValue});
                              if (document['has_completed'] == true) {
                                collection.doc(document.id).delete();
                              }
                            },
                          ),);
                    }).toList(),
                  );
                }
              },
            )),
      ),
      floatingActionButton: new FloatingActionButton.extended(
          label: Text('Add Goal Here!', style: TextStyle(color: primaryBackgroundLight),),
          backgroundColor: Colors.black,
          onPressed: () {
            _pushAddTodoScreen();
          },
          tooltip: 'Add task',
          icon: new Icon(
            Icons.bookmark,
            color: primaryBackgroundLight,
            size: 30,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,  
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
                hintText: 'Enter your goal here!',
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

  void confirmCompletedDialogue(String val) {
    Widget confirmButton = FlatButton(
      child: Text('Achieved!'),
      onPressed: () {
        _addTodoItem(val);
        Navigator.pop(context);
      },
    );

    Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog confirm = AlertDialog(
      title: Text('Did you achieve this goal?'),
      content: TextField(
        controller: _goalController
      ),
      actions: [confirmButton, cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return confirm;
      },
    );
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