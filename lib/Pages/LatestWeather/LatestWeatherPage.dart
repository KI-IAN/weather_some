import 'package:flutter/material.dart';
import 'package:weather_some/AssetFiles/ImageAssetsLocation.dart';
import 'package:weather_some/LanguageFiles/EnglishTexts.dart';

class LatestWeatherPage extends StatelessWidget {
  Widget _buildScaffold() => Scaffold(
        backgroundColor: Color(0x05234b),
        appBar: AppBar(
          title: Text(EnglishTexts.addLocation_titleBarLabel),
          backgroundColor: Colors.black38,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: null,
            ),
          ],
        ),
        body: _LatestWeather(),
      );

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }
}

class _LatestWeather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LatestWeatherState();
}

class _LatestWeatherState extends State<_LatestWeather> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
            child: Image(image: AssetImage(ImageAssetsLocation.rainingGifPath))),
      ],
    );
  }
}
