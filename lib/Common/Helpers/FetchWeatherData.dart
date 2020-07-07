import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/CurrentWeatherViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/WeatherForecast/WeatherForecastViewModel.dart';

class FetchWeatherData {
  String baseURL;

  String query;

  String get fullURL {
    return '$baseURL/$query';
  }

  String _exceptionMessage =
      'Failed to load data from web service. Please check your Internet Connection.';

  FetchWeatherData({this.baseURL, this.query});

  Future<CurrentWeatherViewModel> fetchLatestWeather() async {
    try {
      final response = await http.get(fullURL);

      if (response.statusCode == 200) {
        return CurrentWeatherViewModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(_exceptionMessage);
      }
    } catch (ex) {
      throw Exception(_exceptionMessage);
    }
  }

  Future<WeatherForecastViewModel> fetchWeatherForecast() async {
    try {
      final response = await http.get(fullURL);

      if (response.statusCode == 200) {
        return WeatherForecastViewModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(_exceptionMessage);
      }
    } catch (ex) {
      throw Exception(_exceptionMessage);
    }
  }
}
