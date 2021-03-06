import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/models/workouts_model.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/profile_page.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';
import 'package:intl/intl.dart';

class FavoritesPage extends StatefulWidget {

  static final String id = 'favorites_page';

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  TextEditingController _textController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final collection = FirebaseFirestore.instance.collection('favorites');
  String formattedDate = DateFormat('MM-dd-yyyy HH:mm').format(DateTime.now());

  static List<String> workoutsList = WorkoutsModel.workouts;
  List<String> newList = List.from(workoutsList);

  bool isFinding = false;
  Icon searchIcon = Icon(
    Icons.search,
    color: primaryBackgroundLight,
    size: 30,
  );

  Widget cusSearchBar = Text(
    'List down your favorite exercises!',
    style: TextStyle(
      //fontFamily: font,
      fontSize: 20.0,
      color: isDarkMode ? primaryBackgroundLight : primaryBackground,
    ),
  );

  onItemChanged(String value) {
    setState(() {
      newList = workoutsList.toSet()
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
      if (value == '') {
        isFinding = false;
      } else {
        isFinding = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: isDarkMode ? primaryBackground : primaryBackgroundLight,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print(WorkoutsModel.workouts);
              setState(() {
                if (this.searchIcon.icon == Icons.search) {
                  this.searchIcon = Icon(
                    Icons.arrow_forward,
                    color: primaryBackgroundLight,
                    size: 30,
                  );
                  this.cusSearchBar = TextField (
                    controller: _textController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search for workouts here...',
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white70 : primaryBackground,
                        // fontFamily: font,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: primaryTextColor,
                        ),
                        onPressed: () {
                          _textController.clear();
                        },
                      ),
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: primaryTextColor),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)
                        ),
                      ),
                    ),
                    onChanged: onItemChanged,
                  );
                } else {
                  _textController.clear();
                  isFinding = false;
                  this.searchIcon = Icon(
                    Icons.search,
                    color: primaryTextColor,
                  );
                  this.cusSearchBar = Text(
                    'List down your favorite exercises!',
                    style: TextStyle(
                      // fontFamily: font,
                      color: isDarkMode ? primaryBackgroundLight : primaryBackground,
                    ),
                  );
                }
              });
            },
            icon: searchIcon,
          ),
        ],
        title: cusSearchBar,
        elevation: 0.0,
      ),
      body: Column(children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Flexible(
          child: isFinding
              ? ListView.separated(
                  itemCount: newList.length,
                  separatorBuilder: (context, int index) => Divider(
                    height: 35,
                    color: primaryTextColor
                  ),
                  itemBuilder: (context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: InkWell(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.directions_run,
                                    color: primaryTextColor,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${newList[index]} ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    // fontFamily: font,
                                    fontWeight: FontWeight.w400,
                                    color: isDarkMode ? primaryBackgroundLight : primaryBackground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            confirmFavorite(newList[index]);
                          }),
                    );
                  },
                )
              : Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 25.0),
                decoration: BoxDecoration(
                  color: Color(0xff0E164C),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.lerp(Radius.circular(0), Radius.circular(100), 40),
                    topRight: Radius.lerp(Radius.circular(10), Radius.circular(10), 50),
                  )
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: collection.where('email', isEqualTo: auth.currentUser.email).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          return new ListView(
                            children: snapshot.data.docs.map((DocumentSnapshot document) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft:  Radius.circular(10.0),
                                    topRight: Radius.lerp(Radius.circular(30), Radius.circular(30), 6),
                                    bottomRight: Radius.lerp(Radius.circular(30), Radius.circular(30), 6),
                            ),
                          ),
                        elevation: 10.0,
                        color: cardColor,
                        child: ListTile(
                          title: InkWell(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    )),
                                    TextSpan(
                                      text: ' ${document['workout']}',
                                      style: TextStyle(
                                        // fontFamily: font,
                                        color: primaryBackgroundLight,
                                        fontSize: 18,
                                      )
                                    ),
                                  ]),
                              ),
                          ),
                          subtitle: Text(
                            'Favorite added on: ${document['datetime']}',
                            style: TextStyle(
                              // fontFamily: font,
                              color: primaryTextColor,
                              fontSize: 14,
                            ),
                          ),
                        trailing: Icon(Icons.more_vert, color: primaryBackgroundLight),
                      )
                    );
                  }).toList(),
                );
              }
            },
          )),
          ),
        )
      ]),
    );
  }

  void confirmFavorite(String workout) {
      Widget confirmButton =  FlatButton(
      child: Text('Confirm!'),
      onPressed: (){
        collection.add({
          "workout": workout,
          "is_favorite": true,
          "datetime": formattedDate,
          "email": auth.currentUser.email,
        });
        Navigator.pop(context);
      },
    );

    Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: (){
        Navigator.pop(context);
      },
    );

    AlertDialog confirm = AlertDialog(
      title: Text('Confirmation'),
      content: Text('Do you want to add this to your favorite?'),
      actions: [confirmButton, cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return confirm;
      },
    );
  }
}