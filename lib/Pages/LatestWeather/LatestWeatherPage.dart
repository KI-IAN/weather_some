import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_some/AssetFiles/ImageAssetsLocation.dart';
import 'package:weather_some/Common/Helpers/FetchWeatherData.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/CurrentWeatherViewModel.dart';
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
    return _buildLatestWeatherView();
  }

  Widget _buildLatestWeatherView() {
    String tempBaseUrl = 'https://api.openweathermap.org/data/2.5';
    String tempApiKey = 'df8e460123d8c8ba74db460203f42191';
    String tempQueryParameters = 'weather?q=Cheras&appid=$tempApiKey';

    return FutureBuilder<CurrentWeatherViewModel>(
      future: FetchWeatherData(baseURL: tempBaseUrl, query: tempQueryParameters)
          .fetchCurrentWeather(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<CurrentWeatherViewModel>(
            create: (context) => snapshot.data,
            builder: (context, widget) {
              return Column(
                children: <Widget>[
                  Center(
                      child: Image(
                          image:
                              AssetImage(ImageAssetsLocation.moonBrokenCloud))),
                  Text(
                    'Latitude  : ${Provider.of<CurrentWeatherViewModel>(context, listen: false).coordinate.latitude}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Longitude : ${Provider.of<CurrentWeatherViewModel>(context, listen: false).coordinate.longitude}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
