import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:weather_some/Common/ViewModels/SimpleMaps/CityInfoViewModels.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationSearchViewModel.dart';
import 'package:weather_some/Repository/Models/SavedLocation.dart';
import 'package:weather_some/Repository/SavedLocationRepository.dart';

class LocationSearchHelper {
  String _malaysianCityFile = 'lib/assets/jsons/malaysia_cities.json';

  Future<LocationSearchViewModel> getAllCities() async {
    var cityData = await rootBundle.loadString(_malaysianCityFile);

    var cityJsonData = json.decode(cityData);

    LocationSearchViewModel locationSearch = LocationSearchViewModel();

    locationSearch.cities = toCityInfoViewModel(cityJsonData);

    return locationSearch;
  }

  List<CityInfoViewModel> toCityInfoViewModel(List<dynamic> jsonData) {
    Iterable list = jsonData;
    return list.map((e) => CityInfoViewModel.fromJson(e)).toList();
  }

  Future<void> addLocation(CityInfoViewModel cityInfo) async {
    SavedLocationRepository savedLocationRepo = SavedLocationRepository();

    SavedLocation savedLocation = SavedLocation(
      cityName: cityInfo.city,
      countryCode: cityInfo.country,
      latitude: cityInfo.lat,
      longitude: cityInfo.lng,
    );

    await savedLocationRepo.insert(savedLocation);
  }
}
