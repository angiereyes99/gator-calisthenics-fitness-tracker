import 'package:flutter/material.dart';


const Color gradientStart = const Color(0xFFC8E6C9);
const Color gradientEnd = const Color(0xFF388E3C);

const primaryBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [gradientStart, gradientEnd],
  ),
);

const navigationBar =  BottomNavigationBar(
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      title: Text('Business'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.school),
      title: Text('School'),
    ),
  ],
  selectedItemColor: Colors.amber[800],
);