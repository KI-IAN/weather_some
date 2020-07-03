import 'package:flutter/material.dart';
import 'package:weather_some/Experimental/PageViewDemo.dart';
import 'package:weather_some/Experimental/PageViewIndicatorDemo.dart';
import 'package:weather_some/Pages/AddLocation/AddLocationPage.dart';

void main() {
  // runApp(
  //     // PageViewDemoPage()
  //     PageViewIndicatorDemo());

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddLocationPage(),
    );
  }
}
