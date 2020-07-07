import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';
import 'package:weather_some/Common/ViewModels/SimpleMaps/CityInfoViewModels.dart';
import 'package:weather_some/Pages/AddLocation/Helpers/LocationSearchHelper.dart';

class LocationSearchViewModel extends BaseViewModel {
  List<CityInfoViewModel> _cities;

  set cities(value) => this._cities = value;

  List<CityInfoViewModel> get cities => this._cities;

  Future<void> addLocation(CityInfoViewModel cityInfo) async {
    LocationSearchHelper helper = LocationSearchHelper();

    await helper.addLocation(cityInfo);
  }
}
