import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/MainViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/WeatherViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/WeatherForecast/CityViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/WeatherForecast/ForecastListViewModel.dart';

class WeatherForecastViewModel extends BaseViewModel {
  ///code Internal parameter
  String code;

  ///message Internal parameter
  num message;

  ///city
  CityViewModel city;

  ///cnt : Number of lines returned by this API call
  num totalResultCount;

  ///list
  List<ForecastListViewModel> forecastList;

  WeatherForecastViewModel(
      {this.code,
      this.message,
      this.city,
      this.totalResultCount,
      this.forecastList});

  factory WeatherForecastViewModel.fromJson(Map<String, dynamic> jsonData) {
    return WeatherForecastViewModel(
      code: jsonData['code'],
      message: jsonData['message'],
      city: CityViewModel.fromJson(jsonData['city']),
      totalResultCount: jsonData['cnt'],
      forecastList:
          getNextNDaysForecast(5, convertToForecastViewModel(jsonData['list'])),
    );
  }
}

List<ForecastListViewModel> getNextNDaysForecast(
    int numberOfDays, List<ForecastListViewModel> forecastList) {
  int totalData = forecastList.length;

  int incrementValue = totalData ~/ numberOfDays;

  List<ForecastListViewModel> filteredList = List<ForecastListViewModel>();

  for (int index = 0; index < totalData; index = index + incrementValue) {
    filteredList.add(forecastList.elementAt(index));
  }

  return filteredList;
}

List<ForecastListViewModel> convertToForecastViewModel(List<dynamic> jsonData) {
  Iterable list = jsonData;
  return list.map((e) => ForecastListViewModel.fromJson(e)).toList();
}
