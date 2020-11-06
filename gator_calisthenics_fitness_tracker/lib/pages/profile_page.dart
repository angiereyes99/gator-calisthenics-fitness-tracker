import 'package:flutter/material.dart';
import 'package:gator_calisthenics_fitness_tracker/models/theme_model.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/login_page.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/workouts_page.dart';
import 'package:gator_calisthenics_fitness_tracker/services/google_signing_service.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';

bool isDarkMode = true;

class ProfilePage extends StatefulWidget {
  static final String id = 'profile_page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ThemeModel selected;
  List<ThemeModel> lightingItems = <ThemeModel>[
    const ThemeModel(
        'Dark Mode',
        Icon(
          Icons.wb_cloudy,
          color: Colors.orange,
        )),
    const ThemeModel(
        'Light Mode',
        Icon(
          Icons.wb_sunny,
          color: Colors.orange,
        ))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? primaryBackground : Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 25,
                    color: primaryTextColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                    fontSize: 25,
                    color: primaryTextColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              DropdownButton<ThemeModel>(
                hint: Text(
                  'Select Theme',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 25,
                  ),
                ),
                value: selected,
                onChanged: (ThemeModel value) {
                  setState(() {
                    selected = value;
                  });
                },
                items: lightingItems.map((ThemeModel lightingItem) {
                  return DropdownMenuItem<ThemeModel>(
                    onTap: () {
                      if (lightingItem.type != 'Dark Mode') {
                        isDarkMode = false;
                      } else {
                        isDarkMode = true;
                      }
                    },
                    value: lightingItem,
                    child: Row(
                      children: <Widget>[
                        lightingItem.icon,
                        SizedBox(width: 10),
                        Text(
                          lightingItem.type,
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 30,
                            //fontFamily: font,
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 40,),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), ModalRoute.withName('/'));
                },
                color: primaryTextColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}