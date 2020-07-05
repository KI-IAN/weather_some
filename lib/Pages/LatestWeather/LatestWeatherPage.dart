import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_some/AssetFiles/ImageAssetsLocation.dart';
import 'package:weather_some/Common/Helpers/FetchWeatherData.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/CurrentWeatherViewModel.dart';
import 'package:weather_some/LanguageFiles/EnglishTexts.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';
import 'package:weather_some/Pages/LatestWeather/Helper/LatestWeatherPageHelper.dart';

class LatestWeatherPage extends StatelessWidget {
  Widget _buildScaffold() => FutureBuilder(
        future: LatestWeatherPageHelper().getSelectedLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider<LocationViewModel>(
              create: (context) => snapshot.data,
              builder: (context, widget) {
                return Scaffold(
                  backgroundColor: Colors.indigo[300],
                  appBar: AppBar(
                    title: Text(
                        Provider.of<LocationViewModel>(context, listen: false)
                            .cityName),
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
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
        },
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
  Future<CurrentWeatherViewModel> latestWeatherData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeatherData();
  }

  void fetchWeatherData() async {
    String latitude =
        Provider.of<LocationViewModel>(context, listen: false).latitude;

    String longitude =
        Provider.of<LocationViewModel>(context, listen: false).longitude;

    String tempBaseUrl = 'https://api.openweathermap.org/data/2.5';
    String tempApiKey = 'df8e460123d8c8ba74db460203f42191';
    String tempUnit = 'metric';
    // String tempQueryParameters =
    //     'weather?q=Cheras&units=metric&appid=$tempApiKey';

    String tempQueryParameters =
        'weather?lat=$latitude&lon=$longitude&units=metric&appid=$tempApiKey';

    latestWeatherData =
        FetchWeatherData(baseURL: tempBaseUrl, query: tempQueryParameters)
            .fetchLatestWeather();
  }

  @override
  Widget build(BuildContext context) {
    return _buildLatestWeatherView();
  }

  Widget _buildLatestWeatherView() {
    // String tempBaseUrl = 'https://api.openweathermap.org/data/2.5';
    // String tempApiKey = 'df8e460123d8c8ba74db460203f42191';
    // String tempUnit = 'metric';
    // String tempQueryParameters =
    //     'weather?q=Cheras&units=metric&appid=$tempApiKey';

    return FutureBuilder<CurrentWeatherViewModel>(
      // future: FetchWeatherData(baseURL: tempBaseUrl, query: tempQueryParameters)
      //     .fetchLatestWeather(),
      future: latestWeatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ChangeNotifierProvider<CurrentWeatherViewModel>(
            create: (context) => snapshot.data,
            builder: (context, widget) {
              return Column(
                children: <Widget>[
                  Center(
                      child: Image(
                          image: AssetImage(
                              ImageAssetsLocation.placeHolderImage))),
                  Text(
                    '${Provider.of<CurrentWeatherViewModel>(context, listen: false).main.temp}°C',
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: 60,
                    ),
                  ),
                  Text(
                    '${Provider.of<CurrentWeatherViewModel>(context, listen: false).weather.description.toUpperCase()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontSize: 30,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '↑ ${Provider.of<CurrentWeatherViewModel>(context, listen: false).main.maximumTemperature}°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '↓ ${Provider.of<CurrentWeatherViewModel>(context, listen: false).main.minimumTemperature}°C',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Humidity : ',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${Provider.of<CurrentWeatherViewModel>(context, listen: false).main.humidity}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Wind : ',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${Provider.of<CurrentWeatherViewModel>(context, listen: false).wind.speed} m/s',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: true,
                      child: Text(
                          '${Provider.of<LocationViewModel>(context, listen: false).latitude} / ${Provider.of<LocationViewModel>(context, listen: false).longitude}')),
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        }
      },
    );
  }
}
