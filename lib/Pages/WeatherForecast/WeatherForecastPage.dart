import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_some/AssetFiles/ImageAssetsLocation.dart';
import 'package:weather_some/Common/Helpers/FetchWeatherData.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/WeatherForecast/WeatherForecastViewModel.dart';
import 'package:weather_some/LanguageFiles/EnglishTexts.dart';

class WeatherForecastPage extends StatelessWidget {
  Widget _buildScaffold() => Scaffold(
        backgroundColor: Colors.indigo[300],
        appBar: AppBar(
          title: Text(EnglishTexts.addLocation_titleBarLabel),
          backgroundColor: Colors.indigo[300],
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
        body: WeatherForecast(),
      );

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }
}

class WeatherForecast extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherForecastState();
}

class WeatherForecastState extends State<WeatherForecast> {
  GlobalKey<AnimatedListState> forecastListState =
      GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    String tempBaseUrl = 'https://api.openweathermap.org/data/2.5';
    String tempApiKey = 'df8e460123d8c8ba74db460203f42191';
    String tempUnit = 'metric';
    String tempQueryParameters =
        'forecast?q=Cheras&units=metric&appid=$tempApiKey';

    return FutureBuilder(
        future:
            FetchWeatherData(baseURL: tempBaseUrl, query: tempQueryParameters)
                .fetchWeatherForecast(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider<WeatherForecastViewModel>(
              create: (context) => snapshot.data,
              builder: (context, widget) {
                return AnimatedList(
                  initialItemCount: Provider.of<WeatherForecastViewModel>(
                          context,
                          listen: false)
                      .forecastList
                      .length,
                  key: forecastListState,
                  itemBuilder: (context, currentIndex, animation) {
                    var currentItem = Provider.of<WeatherForecastViewModel>(
                            context,
                            listen: false)
                        .forecastList
                        .elementAt(currentIndex);

                    return Card(
                      color: Colors.indigo[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                currentItem.forecastedDateTimeInString,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                currentItem.weather.description,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Image(
                            width: 40,
                            height: 40,
                              image: AssetImage(
                                  ImageAssetsLocation.placeHolderImage)),
                          Text(
                            '↑${currentItem.main.maximumTemperature.toStringAsFixed(0)}°C',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '↓${currentItem.main.minimumTemperature.toStringAsFixed(0)}°C',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white54,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
