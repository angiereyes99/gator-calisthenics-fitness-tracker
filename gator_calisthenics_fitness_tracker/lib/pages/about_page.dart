import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';

class AboutPage extends StatefulWidget {
  static final String id = 'about_page';

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: primaryTextColor,
        elevation: 0,
        title: Text(
          'About',
          style: TextStyle(
            fontFamily: font,
            fontSize: 30,
          ),
        ),
      ),
      backgroundColor: primaryTextColor,
      body: Center(
        child: Container(
        alignment: Alignment(0, -1),
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    aboutBio,
                    style: TextStyle(
                      fontFamily: font,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          )),
      ),
    );
  }
}