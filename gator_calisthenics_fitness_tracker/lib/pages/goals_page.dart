import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';

class GoalsPage extends StatefulWidget {

  static final String id = 'goals_page';

  @override
  createState() => new GoalsPageState();
}

class GoalsPageState extends State<GoalsPage> {

  final firestoreInstance = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  List<String> _todoItems = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: new Text('Set Goals Here')
      ),
      body: Center(
      child: Container(
        decoration: primaryBackground,
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('todos')
            .snapshots(),
          builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new ListView(
                    children: snapshot.data.docs
                      .map((DocumentSnapshot document) {
                        return new Text(
                          document['todo_item'],
                          //description: document['description'],
                        );
                    }).toList(),
                  );
              }
            },
          )),
        ),
        floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.green[900],
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(
          Icons.add,
          color: Colors.black,
        )
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.green[800],
              title: new Text('Add a new goal')
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context); // Close the add todo screen
              },
              decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)
              ),
            )
          );
        }
      )
    );
  }

  void _addTodoItem(String task) {
    if(task.length > 0) {
    firestoreInstance.collection("todos").add(
    {
      "email": auth.currentUser.email,
      "todo_item": task,
      "has_completed": false,
    }).then((value){
      print(value.id);
    });
      setState(() => _todoItems.add(task));
    }
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
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('MARK AS DONE'),
              onPressed: () {
                _removeTodoItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }
}