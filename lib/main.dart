import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_some/Pages/MainPage/MainAppCarouselPage.dart';

void main() {

  
  WidgetsFlutterBinding.ensureInitialized();    // To Avoid errors caused by flutter upgrade.
  setDeviceOrientation();
  runApp(MainApp());
}

void setDeviceOrientation() {
  //Set device orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainAppCarouselPage(),
    );
  }
}
