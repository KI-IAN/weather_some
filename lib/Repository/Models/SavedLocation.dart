class SavedLocation {

  int id;

  String cityName;

  String countryCode;

  String latitude;

  String longitude;

  String stateCode;

  int isDeleteable;

  int isSelectedCity;

  SavedLocation(
      {this.id,
      this.cityName,
      this.countryCode,
      this.latitude,
      this.longitude,
      this.stateCode,
      this.isDeleteable,
      this.isSelectedCity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cityName': cityName,
      'countryCode': countryCode,
      'latitude': latitude,
      'longitude': longitude,
      'stateCode': stateCode,
      'isDeleteable': isDeleteable,
      'isSelectedCity': isSelectedCity,
    };
  }
}
