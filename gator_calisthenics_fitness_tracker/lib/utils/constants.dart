import 'package:flutter/material.dart';


const primaryBackground = const Color(0xFF010A43);
const primaryBackgroundLight = const Color(0xFFFFFFFF);
const primaryTextColor = const Color(0xFFFF2E63);
const navbarColor = const Color(0x1FFFFFFF);
const font = 'Ubuntu';

Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
}

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}
double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

/** UNUSED VARIABLES **/
const Color gradientStart = const Color(0xFFC8E6C9);
const Color gradientEnd = const Color(0xFF388E3C);

/** UNUSED METHOD **/
const primaryBackground_unused = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [gradientStart, gradientEnd],
  ),
);

const String aboutBio = 'Gator Calisthenics was developed during the COVID-19 pandemic.' +
                        '\n\nWith many of the businesses, including gyms, closed, it seemed hard for' +
                        ' many to find the motivation to be productive. While quarantine may have been' +
                        ' a barrier for many, this app was desgined with the hopes to keep those who use it,' +
                        ' motivated and ready to improve even during quarantine. Gator Calisthenics is' +
                        ' a workout application where you dont need fancy equipment to improve your health.';