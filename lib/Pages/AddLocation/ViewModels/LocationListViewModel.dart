import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';

class LocationListViewModel extends BaseViewModel {
  List<LocationViewModel> _locationList;

  List<LocationViewModel> get locationList => this._locationList;

  set locationList(List<LocationViewModel> locations) =>
      this._locationList = locations;



  
}
