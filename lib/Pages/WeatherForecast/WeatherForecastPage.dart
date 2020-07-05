import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_some/AssetFiles/ImageAssetsLocation.dart';
import 'package:weather_some/Common/Helpers/FetchWeatherData.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/WeatherForecast/WeatherForecastViewModel.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';
import 'package:weather_some/Pages/LatestWeather/Helper/LatestWeatherPageHelper.dart';

class WeatherForecastPage extends StatelessWidget {
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
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            '${Provider.of<LocationViewModel>(context, listen: false).cityName}'),
                        Text(
                          'Next 5 days',
                          style: TextStyle(fontSize: 12, color: Colors.white60),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
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
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
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

class WeatherForecast extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherForecastState();
}

class WeatherForecastState extends State<WeatherForecast> {
  GlobalKey<AnimatedListState> forecastListState =
      GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    var latitude =
        Provider.of<LocationViewModel>(context, listen: false).latitude;

    var longitude =
        Provider.of<LocationViewModel>(context, listen: false).longitude;

    String tempBaseUrl = 'https://api.openweathermap.org/data/2.5';
    String tempApiKey = 'df8e460123d8c8ba74db460203f42191';
    String tempUnit = 'metric';
    // String tempQueryParameters =
    //     'forecast?q=Cheras&units=metric&appid=$tempApiKey';
    String tempQueryParameters =
        'forecast?lat=$latitude&lon=$longitude&units=$tempUnit&appid=$tempApiKey';

    return FutureBuilder(
        future:
            FetchWeatherData(baseURL: tempBaseUrl, query: tempQueryParameters)
                .fetchWeatherForecast(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
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

                    return Container(
                      padding: EdgeInsets.all(5),
                      height: 100,
                      child: Card(
                        // color: Colors.indigo[300],
                        color: Colors.white,
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 12.0,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        currentItem.foreCastedDate,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        currentItem.weather.description
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Image(
                                  width: 100,
                                  height: 100,
                                  // image: AssetImage(
                                  //     ImageAssetsLocation.placeHolderImage)
                                  image: NetworkImage(
                                      'http://openweathermap.org/img/wn/${currentItem.weather.icon}@4x.png'),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '↑${currentItem.main.maximumTemperature.toStringAsFixed(2)}°C',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '↓${currentItem.main.minimumTemperature.toStringAsFixed(2)}°C',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(
              
              child: Container(
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new AssetImage(
                              ImageAssetsLocation.cloudSunReloader)))),
            );
          }
        });
  }
}
