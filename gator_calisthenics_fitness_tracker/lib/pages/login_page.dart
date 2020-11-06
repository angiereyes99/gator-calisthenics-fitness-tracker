import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: primaryBackground,
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/logo.png"), height: 125.0,),
              SizedBox(height: 25,),
              Text(
                'Gator Calisthenics Fitness Tracker', 
                style: TextStyle(color: primaryTextColor, fontSize: 21.5, fontFamily: font),
              ),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.white,
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
      highlightElevation: 0,
      borderSide: BorderSide(color: primaryTextColor,),
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
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: primaryTextColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}