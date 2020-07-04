import 'package:weather_some/Common/ViewModels/OpenWeatherMapViewModels/CurrentWeather/CoordinateViewModel.dart';

class CityViewModel {
  ///city.id City ID
  num id;

  ///city.name City name
  String name;

  ///city.coord
  ///city.coord.lat City geo location, latitude
  ///city.coord.lon City geo location, longitude
  CoordinateViewModel coordinate;

  ///city.country Country code (GB, JP etc.)
  String countryCode;

  ///city.timezone Shift in seconds from UTC
  num timeZone;

  num sunrise;

  num sunset;

  num population;

  CityViewModel(
      {this.id,
      this.name,
      this.coordinate,
      this.countryCode,
      this.timeZone,
      this.sunrise,
      this.sunset,
      this.population});

  factory CityViewModel.fromJson(Map<String, dynamic> jsonData) {
    return CityViewModel(
      id: jsonData['id'],
      name: jsonData['name'],
      coordinate: CoordinateViewModel.fromJson(jsonData['coord']),
      countryCode: jsonData['country'],
      timeZone: jsonData['timezone'],
    );
  }
}
