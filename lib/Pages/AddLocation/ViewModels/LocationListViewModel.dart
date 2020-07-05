import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';
import 'package:weather_some/Pages/AddLocation/Helpers/LocationListPageHelper.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';

class LocationListViewModel extends BaseViewModel {
  List<LocationViewModel> _locationList;

  List<LocationViewModel> get locationList => this._locationList;

  set locationList(List<LocationViewModel> locations) =>
      this._locationList = locations;

  int _selectedLocationId = -1;

  set selectedLocationId(value) {
    this._selectedLocationId = value;
    this.invokeChanges();
  }

  int get selectedLocationId {
    this._selectedLocationId =
        locationList.where((r) => r.isSelectedCity == 1).first.id;
    return this._selectedLocationId;
  }

  Future<void> deleteLocation(int locationId) async {
    LocationListPageHelper helper = LocationListPageHelper();


    await helper.deleteLocation(locationId, selectedLocationId);

    locationList.remove(locationList.where((r) => r.id == locationId).first);

    this.invokeChanges();
  }

  Future<void> setSelectedLocation(int locationId) async {
    LocationListPageHelper helper = LocationListPageHelper();

    await helper.setSelectedLocation(locationId);

    this.invokeChanges();
  }
}
