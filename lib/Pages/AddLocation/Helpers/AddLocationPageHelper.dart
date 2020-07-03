import 'dart:math';

import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';

class AddLoctionPageHelper {
  Future<List<LocationViewModel>> getAllLocations() async {
    var locationData = await generateRandomLocations();
    return locationData;
  }

// #region: Generate random data

  Future<List<LocationViewModel>> generateRandomLocations() async {
    List<LocationViewModel> locations = List<LocationViewModel>();

    for (int locationNo = 1; locationNo < 10; locationNo++) {
      locations.add(LocationViewModel(
          currentDateTime: DateTime.now(),
          currentTemperature: Random().nextDouble() * 20,
          locationName: 'Location No# $locationNo',
          weatherDescription: 'Weather Description....'));
    }

    return locations;
  }

// #endRegion

}
