import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:weather_some/Pages/AddLocation/AddLocationPage.dart';
import 'package:weather_some/Pages/LatestWeather/LatestWeatherPage.dart';
import 'package:weather_some/Pages/WeatherForecast/WeatherForecastPage.dart';

class MainAppCarouselPage extends StatelessWidget {
  static const length = 3;
  final pageIndexNotifier = ValueNotifier<int>(0);
  final bodyBackgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyBackgroundColor,
      body: Stack(
        alignment: FractionalOffset.bottomCenter,
        children: <Widget>[
          PageView.builder(
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) => pageIndexNotifier.value = index,
              itemCount: length,
              itemBuilder: (context, index) {
                Widget selectedPageView;

                if (index == 0) {
                  selectedPageView = AddLocationPage();
                } else if (index == 1) {
                  selectedPageView = LatestWeatherPage();
                } else if (index == 2) {
                  selectedPageView = WeatherForecastPage();
                }

                return selectedPageView;
              }),
          // PageView(
          //   children: <Widget>[
          //     AddLocationPage(),
          //     LatestWeatherPage(),
          //     WeatherForecastPage(),
          //   ],
          // ),
          _buildCircularIndicator(),
          // _buildCircularIndicator2(),
          // _buildIconIndicator(),
        ],
      ),
    );
  }

  PageViewIndicator _buildCircularIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.white60,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 16.0,
          // color: Colors.accents.elementAt((index + length) * length),
          color: Colors.white,
        ),
      ),
    );
  }
}
