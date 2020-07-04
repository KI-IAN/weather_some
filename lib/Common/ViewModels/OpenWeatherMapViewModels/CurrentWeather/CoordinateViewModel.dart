class CoordinateViewModel {
  ///City geo location, longitude
  double longitude;

  ///City geo location, latitude
  double latitude;

  CoordinateViewModel({this.longitude, this.latitude});

  factory CoordinateViewModel.fromJson(Map<String, dynamic> jsonData) {
    return CoordinateViewModel(
      longitude: jsonData['lon'],
      latitude: jsonData['lat'],
    );
  }
}
