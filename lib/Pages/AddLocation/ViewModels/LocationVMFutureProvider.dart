import 'package:weather_some/Pages/AddLocation/Helpers/AddLocationPageHelper.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/AddLocationViewModel.dart';

class LocationVMFutureProvider {
  Future<AddLocationViewModel> getAllLocations() async {
    AddLoctionPageHelper helper = AddLoctionPageHelper();

    AddLocationViewModel location = AddLocationViewModel();

    location.locationList = await helper.getAllLocations();

    return location;
  }

// #region : Temp Data

// #endRegion : Temp Data

}
