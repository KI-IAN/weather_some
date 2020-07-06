import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';
import 'package:weather_some/Common/ViewModels/SimpleMaps/CityInfoViewModels.dart';
import 'package:weather_some/Pages/AddLocation/Helpers/LocationSearchHelper.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';

class GeoLocationViewModel extends BaseViewModel {
  LocationViewModel location;

  GeoLocationViewModel({this.location});

  Future<void> addLocation() async {
    LocationSearchHelper helper = LocationSearchHelper();

    CityInfoViewModel cityInfo = CityInfoViewModel(
      city: location.cityName,
      country: location.countryCode,
      lat: location.latitude,
      lng: location.longitude,
    );

    await helper.addLocation(cityInfo);
  }
}
