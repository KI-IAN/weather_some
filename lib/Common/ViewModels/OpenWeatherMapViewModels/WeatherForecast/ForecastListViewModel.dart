import 'package:intl/intl.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/CloudsViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/MainViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/RainViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/SnowViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/WeatherViewModel.dart';
import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/WindViewModel.dart';

class ForecastListViewModel {
  ///list.dt Time of data forecasted, unix, UTC
  num forecastedDateTime;

  String get foreCastedDate {
    var date = DateTime.parse(forecastedDateTimeInString);
    final dateFormat = new DateFormat('dd MMMM');
    return '${dateFormat.format(date)}';
  }

  ///list.main
  MainViewModel main;

  ///list.weather (more info Weather condition codes)
  WeatherViewModel weather;

  ///list.clouds
  CloudsViewModel clouds;

  ///list.wind
  WindViewModel winds;

  ///list.rain
  RainViewModel rain;

  ///list.snow
  SnowViewModel snow;

  ///list.dt_txt Time of data forecasted, ISO, UTC
  String forecastedDateTimeInString;

  ForecastListViewModel(
      {this.forecastedDateTime,
      this.main,
      this.weather,
      this.clouds,
      this.winds,
      this.rain,
      this.snow,
      this.forecastedDateTimeInString});

  factory ForecastListViewModel.fromJson(Map<String, dynamic> jsonData) {
    return ForecastListViewModel(
      main: MainViewModel.fromJson(jsonData['main']),
      weather: WeatherViewModel.fromJson(jsonData['weather']),
      clouds: CloudsViewModel.fromJson(jsonData['clouds']),
      winds: WindViewModel.fromJson(jsonData['wind']),
      // rain: RainViewModel.fromJson(jsonData['rain']),
      forecastedDateTime: jsonData['dt'],
      forecastedDateTimeInString: jsonData['dt_txt'],
      // snow: SnowViewModel.fromJson(jsonData['snow']),
    );
  }
}
