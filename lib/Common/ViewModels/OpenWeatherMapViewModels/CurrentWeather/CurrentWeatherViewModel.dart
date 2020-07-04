import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/CloudsViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/CoordinateViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/MainViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/RainViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/SnowViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/SysViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/WeatherViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/WindViewModel.dart';

class CurrentWeatherViewModel extends BaseViewModel {
  CoordinateViewModel coordinate;

  WeatherViewModel weather;

  ///Internal parameter
  String base;

  MainViewModel main;

//visibility.value Visibility, meter
  num visibility;

  WindViewModel wind;

  CloudsViewModel clouds;

  RainViewModel rain;

  SnowViewModel snow;

  ///dt Time of data calculation, unix, UTC
  num dataCirculationTime;

  SysViewModel sys;

  ///timezone Shift in seconds from UTC
  num timeZone;

  ///id City ID
  num cityID;

  ///name City name
  String cityName;

  ///cod Internal parameter
  num cod;

  CurrentWeatherViewModel(
      {this.coordinate,
      this.weather,
      this.base,
      this.main,
      this.visibility,
      this.wind,
      this.clouds,
      this.rain,
      this.snow,
      this.dataCirculationTime,
      this.sys,
      this.timeZone,
      this.cityID,
      this.cityName,
      this.cod});

  factory CurrentWeatherViewModel.fromJson(Map<String, dynamic> jsonData) {
    return CurrentWeatherViewModel(
      coordinate: CoordinateViewModel.fromJson(jsonData['coord']),
      weather: WeatherViewModel.fromJson(jsonData['weather']),
      base: jsonData['base'],
      main: MainViewModel.fromJson(jsonData['main']),
      visibility: jsonData['visibility'],
      wind: WindViewModel.fromJson(jsonData['wind']),
      clouds: CloudsViewModel.fromJson(jsonData['clouds']),
      dataCirculationTime: jsonData['dt'],
      sys: SysViewModel.fromJson(jsonData['sys']),
      timeZone: jsonData['timezone'],
      cityID: jsonData['id'],
      cityName: jsonData['name'],
      cod: jsonData['cod'],
    );
  }
}
