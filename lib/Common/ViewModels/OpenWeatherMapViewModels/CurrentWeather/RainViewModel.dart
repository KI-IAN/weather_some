class RainViewModel {
// rain

  ///rain.1h Rain volume for the last 1 hour, mm
  num last1Hour;

  ///rain.3h Rain volume for the last 3 hours, mm
  num last3Hours;

  RainViewModel({this.last1Hour, this.last3Hours});

  factory RainViewModel.fromJson(Map<String, dynamic> jsonData) {
    return RainViewModel(
      // last1Hour: jsonData['1h'],
      last3Hours: jsonData['3h'],
    );
  }
}
