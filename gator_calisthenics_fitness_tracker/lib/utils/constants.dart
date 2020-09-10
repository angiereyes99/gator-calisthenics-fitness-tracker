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