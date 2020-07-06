import 'package:location/location.dart';
import 'package:weather_some/Common/Helpers/FetchWeatherData.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/GeoLocationViewModel.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';

class GeoLocationVMFutureProvider {
  Future<GeoLocationViewModel> getCurrentLocation() async {
    var gpsLocation = await _getGPSLocation();
    var geoLocationData =
        await _fetchWeatherData(gpsLocation.latitude, gpsLocation.longitude);

    return GeoLocationViewModel(
      location: geoLocationData,
    );
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
}
