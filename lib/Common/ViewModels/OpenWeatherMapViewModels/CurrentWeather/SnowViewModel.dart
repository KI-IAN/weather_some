class SnowViewModel {
  ///snow.1h Snow volume for the last 1 hour, mm
  num last1Hour;

  ///snow.3h Snow volume for the last 3 hours, mm
  num last3Hours;

  SnowViewModel({this.last1Hour, this.last3Hours});

  factory SnowViewModel.fromJson(Map<String, dynamic> jsonData) {
    return SnowViewModel(
      // last1Hour: jsonData['1h'],
      last3Hours: jsonData['3h'],
    );
  }
}
