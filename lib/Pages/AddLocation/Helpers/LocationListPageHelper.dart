import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';
import 'package:weather_some/Repository/Models/SavedLocation.dart';
import 'package:weather_some/Repository/SavedLocationRepository.dart';

class LocationListPageHelper {
  SavedLocationRepository _savedLocationRepo;

  LocationListPageHelper() {
    _savedLocationRepo = SavedLocationRepository();
  }

  Future<List<LocationViewModel>> getAllLocations() async {
    List<SavedLocation> locations =
        await _savedLocationRepo.allSavedLocations();

    return List.generate(locations.length, (index) {
      return LocationViewModel(
        id: locations.elementAt(index).id,
        cityName: locations.elementAt(index).cityName,
        countryCode: locations.elementAt(index).countryCode,
        isDeleteable: locations.elementAt(index).isDeleteable,
        isSelectedCity: locations.elementAt(index).isSelectedCity,
        latitude: locations.elementAt(index).latitude,
        longitude: locations.elementAt(index).longitude,
        stateCode: locations.elementAt(index).stateCode,
      );
    });
  }

  Future<void> deleteLocation(int locationId) async {
    SavedLocationRepository savedLocationRepo = SavedLocationRepository();

    await savedLocationRepo.delete(locationId);
  }
}
