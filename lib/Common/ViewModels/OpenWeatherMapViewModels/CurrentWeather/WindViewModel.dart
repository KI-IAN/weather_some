class WindViewModel {
  /// wind.speed Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
  num speed;

  /// wind.deg Wind direction, degrees (meteorological)
  num directionInDegrees;

  /// wind.gust Wind gust. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour
  num gust;

  WindViewModel({this.speed, this.directionInDegrees, this.gust});

  factory WindViewModel.fromJson(Map<String, dynamic> jsonData) {
    return WindViewModel(
      speed: jsonData['speed'],
      directionInDegrees: jsonData['deg'],
      gust: jsonData['gust'],
    );
  }
}
