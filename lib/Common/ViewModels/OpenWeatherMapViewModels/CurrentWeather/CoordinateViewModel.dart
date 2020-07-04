class CoordinateViewModel {
  ///City geo location, longitude
  num longitude;

  ///City geo location, latitude
  num latitude;

  CoordinateViewModel({this.longitude, this.latitude});

  factory CoordinateViewModel.fromJson(Map<String, dynamic> jsonData) {
    return CoordinateViewModel(
      longitude: jsonData['lon'],
      latitude: jsonData['lat'],
    );
  }
}
