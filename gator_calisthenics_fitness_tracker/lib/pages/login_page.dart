import 'package:flutter/material.dart';
import 'package:flutter_particles/particles.dart';
import 'package:gator_calisthenics_fitness_tracker/pages/about_page.dart';
import 'package:gator_calisthenics_fitness_tracker/services/google_signing_service.dart';
import 'package:gator_calisthenics_fitness_tracker/services/main_navigation.dart';
import 'package:gator_calisthenics_fitness_tracker/utils/constants.dart';

class LoginPage extends StatefulWidget {
  static final String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 40.0),
            decoration: BoxDecoration(
                color: Color(0xff0E164C),
                borderRadius: BorderRadius.only(
                  topLeft:
                      Radius.lerp(Radius.circular(0), Radius.circular(0), 50),
                  topRight: 
                      Radius.lerp(Radius.circular(0), Radius.circular(100), 50),
                  bottomLeft:
                      Radius.lerp(Radius.circular(0), Radius.circular(0), 50),
                  bottomRight:
                      Radius.lerp(Radius.circular(0), Radius.circular(100), 50),
                )),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/homelogo.PNG"),
                height: 180.0,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Gator Calisthenics Fitness Tracker',
                style: TextStyle(
                  fontSize: 32.0,
                  fontFamily: font,
                  color: primaryBackgroundLight,
                ),
              ),
              Text(
                'Begin your calisthenics journey!',
                style: TextStyle(
                  fontSize: 20.0,
                  height: 3.5,
                  fontWeight: FontWeight.w400,
                  color: primaryBackgroundLight,
                  fontFamily: font,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              _signInButton(),
              SizedBox(
                height: 25,
              ),
              _aboutLink(),
            ],
          )),
        ],
      ),
    );
  }

  Widget _signInButton() {
    return MaterialButton(
      color: primaryBackgroundLight,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MainNavigation();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 15.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '| Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: font,
                  color: primaryTextColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _aboutLink() {
    return InkWell(
      child: Text('About',
          style: TextStyle(
              color: primaryTextColor, fontFamily: font, fontSize: 20)),
      onTap: () {
        Navigator.pushNamed(context, AboutPage.id);
      },
    );
  }
}