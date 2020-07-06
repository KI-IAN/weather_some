import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_some/Experimental/FetchNetworkData.dart';
import 'package:weather_some/Experimental/PageViewDemo.dart';
import 'package:weather_some/Experimental/PageViewIndicatorDemo.dart';
import 'package:weather_some/Experimental/RadioButtonDemo.dart';
import 'package:weather_some/Pages/AddLocation/LocationListPage.dart';
import 'package:weather_some/Pages/LatestWeather/LatestWeatherPage.dart';
import 'package:weather_some/Pages/MainPage/MainAppCarouselPage.dart';
import 'package:weather_some/Pages/WeatherForecast/WeatherForecastPage.dart';

void main() {

  // Avoid errors caused by flutter upgrade.
  WidgetsFlutterBinding.ensureInitialized();
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
      // home: AddLocationPage(),
      // home: LatestWeatherPage(),
      // home: LatestWeatherPage(),
      // home: WeatherForecastPage(),
      home: MainAppCarouselPage(),
      // home: RadioButtonDemo(),
    );
  }
}
