import 'package:weather_some/Pages/AddLocation/Helpers/LocationListPageHelper.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationListViewModel.dart';

class LocationVMFutureProvider {
  Future<LocationListViewModel> getAllLocations() async {
    LocationListPageHelper helper = LocationListPageHelper();

    LocationListViewModel location = LocationListViewModel();

    location.locationList = await helper.getAllLocations();

    return location;
  }

// #region : Temp Data

// #endRegion : Temp Data

}
