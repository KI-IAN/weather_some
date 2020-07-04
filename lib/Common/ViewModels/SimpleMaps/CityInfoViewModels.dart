import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';

class CityInfoViewModel extends BaseViewModel {
  String city;

  String admin;

  String country;

  String populationProper;

  String iso2;

  String capital;

  String lat;

  String lng;

  String population;

  CityInfoViewModel(
      {this.city,
      this.admin,
      this.country,
      this.populationProper,
      this.iso2,
      this.capital,
      this.lat,
      this.lng,
      this.population});

  factory CityInfoViewModel.fromJson(Map<String, dynamic> jsonData) {
    return CityInfoViewModel(
      admin: jsonData['admin'],
      capital: jsonData['capital'],
      city: jsonData['city'],
      country: jsonData['country'],
      iso2: jsonData['iso2'],
      lat: jsonData['lat'],
      lng: jsonData['lng'],
      population: jsonData['population'],
      populationProper: jsonData['populationProper'],
    );
  }
}
