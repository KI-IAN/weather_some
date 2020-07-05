import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';

class LocationViewModel extends BaseViewModel {

  int id;

  String cityName;

  String countryCode;

  String latitude;

  String longitude;

  String stateCode;

  int isDeleteable;

  int isSelectedCity;

  set isSelectedCityProp(value) => this.isSelectedCity = value;

  bool get isSelectedCityProp {
    return intToBoolean(this.isSelectedCity);
  }

  set isDeleteableProp(value) => this.isDeleteable = value;

  bool get isDeleteableProp {
    return intToBoolean(this.isDeleteable);
  }

  bool intToBoolean(int value) {
    return (value == 1) ? true : false;
  }

  LocationViewModel(
      {this.id,
      this.cityName,
      this.countryCode,
      this.latitude,
      this.longitude,
      this.stateCode,
      this.isDeleteable,
      this.isSelectedCity});
}
