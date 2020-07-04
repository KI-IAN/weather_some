class SysViewModel {
  ///sys.type Internal parameter
  num type;

  ///sys.id Internal parameter
  num id;

  ///sys.message Internal parameter
  String message;

  ///sys.country Country code (GB, JP etc.)
  String country;

  ///sys.sunrise Sunrise time, unix, UTC
  num sunrise;

  ///sys.sunset Sunset time, unix, UTC
  num sunset;

  SysViewModel(
      {this.type,
      this.id,
      this.message,
      this.country,
      this.sunrise,
      this.sunset});

  factory SysViewModel.fromJson(Map<String, dynamic> jsonData) {
    return SysViewModel(
      type: jsonData['type'],
      id: jsonData['id'],
      country: jsonData['country'],
      message: jsonData['message '],
      sunrise: jsonData['sunrise'],
      sunset: jsonData['sunset'],
    );
  }
}
