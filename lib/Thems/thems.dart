
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData themeLight = ThemeData(

  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Colors.grey[600],
    ),
    bodyText1: const TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.bold),
  ),
  fontFamily: 'jannah',
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
    elevation: 0.0,
  ),
);

ThemeData themeDark =  ThemeData(

  textTheme: TextTheme(

    bodyText2: TextStyle(
      color: Colors.grey[400],
    ),
    bodyText1: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.bold),
  ),
  fontFamily: 'jannah',
  primarySwatch: Colors.blue,

  scaffoldBackgroundColor: HexColor('333739'),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.white30,
    backgroundColor: Colors.black12,
    elevation: 1.5,
  ),

  appBarTheme: AppBarTheme(

    backgroundColor: HexColor('333739'),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: HexColor('333739'),
    ),
    elevation: 0.0,
  ),
);