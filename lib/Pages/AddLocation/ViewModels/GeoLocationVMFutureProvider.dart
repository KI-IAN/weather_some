import 'package:location/location.dart';
import 'package:weather_some/Common/Helpers/FetchWeatherData.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/GeoLocationViewModel.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';

class GeoLocationVMFutureProvider {
  Future<GeoLocationViewModel> getCurrentLocation() async {
    try {
      var isServiceEnabled = await _isServiceEnabled();

      if (isServiceEnabled == false) {
        throw Exception(
            'Location is not enabled. Please enable it to get your current location.');
      }

      var hasLocationPermission = await _hasLocationPermission();
      if (hasLocationPermission != PermissionStatus.GRANTED) {
        throw Exception(
            'Location permission is denied. Please grant permission to get your current location.');
      }

      var gpsLocation = await _getGPSLocation();
      var geoLocationData =
          await _fetchWeatherData(gpsLocation.latitude, gpsLocation.longitude);

      return GeoLocationViewModel(
        location: geoLocationData,
      );
    } catch (ex) {
      throw ex;
    }
  }

  Future<LocationViewModel> _fetchWeatherData(
      double latitude, double longitude) async {
    String tempBaseUrl = 'https://api.openweathermap.org/data/2.5';
    String tempApiKey = 'df8e460123d8c8ba74db460203f42191';
    String tempUnit = 'metric';

    String tempQueryParameters =
        'weather?lat=${latitude.toString()}&lon=${longitude.toString()}&units=$tempUnit&appid=$tempApiKey';

    var latestWeatherData =
        await FetchWeatherData(baseURL: tempBaseUrl, query: tempQueryParameters)
            .fetchLatestWeather();

    LocationViewModel location = LocationViewModel(
      cityName: latestWeatherData.cityName,
      countryCode: latestWeatherData.sys.country,
      latitude: latitude.toString(),
      longitude: longitude.toString(),
    );

    return location;
  }

  Future<LocationData> _getGPSLocation() async {
    var location = new Location();
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  Future<bool> _isServiceEnabled() async {
    var location = new Location();

    var isServiceEnabled = await location.serviceEnabled();

    if (isServiceEnabled == false) {
      isServiceEnabled = await location.requestService();
    }

    return isServiceEnabled;
  }

  Future<PermissionStatus> _hasLocationPermission() async {
    var location = new Location();

    var hasLocationPermission = await location.hasPermission();

    if (hasLocationPermission != PermissionStatus.GRANTED) {
      hasLocationPermission = await location.requestPermission();
    }

    return hasLocationPermission;
  }
}
