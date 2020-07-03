import 'package:weather_some/Common/ViewModels/BaseViewModel.dart';

class LocationViewModel extends BaseViewModel {
  String locationName;
  DateTime currentDateTime;
  double currentTemperature;
  String weatherDescription;

  LocationViewModel(
      {this.locationName,
      this.currentDateTime,
      this.currentTemperature,
      this.weatherDescription});
}
