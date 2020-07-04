import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';
import 'package:weather_some/Common/ViewModels/SimpleMaps/CityInfoViewModels.dart';

class LocationSearchViewModel extends BaseViewModel {
  List<CityInfoViewModel> _cities;

  set cities(value) => this._cities = value;

  List<CityInfoViewModel> get cities => this._cities;
}
