import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/CurrentWeatherViewModel.dart';

class FetchWeatherData {
  String baseURL;

  String query;

  String get fullURL {
    return '$baseURL/$query';
  }

  FetchWeatherData({this.baseURL, this.query});

  Future<CurrentWeatherViewModel> fetchCurrentWeather() async {
    final response = await http.get(fullURL);

    if (response.statusCode == 200) {
      return CurrentWeatherViewModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data...');
    }
  }
}
