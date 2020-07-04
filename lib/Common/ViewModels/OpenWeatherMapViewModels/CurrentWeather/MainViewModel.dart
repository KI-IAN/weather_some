class MainViewModel {
  ///Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  double temp;

  ///Temperature. This temperature parameter accounts for the human
  double feelsLike;

  ///Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
  int pressure;

  ///Humidity, %
  int humidity;

  ///Minimum temperature at the moment. This is minimal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  double minimumTemperature;

  ///Maximum temperature at the moment. This is maximal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  double maximumTemperature;

  ///Atmospheric pressure on the sea level, hPa
  int seaLevelPressure;

  ///Atmospheric pressure on the ground level, hPa
  int groundLevelPressure;

  MainViewModel(
      {this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.minimumTemperature,
      this.maximumTemperature,
      this.seaLevelPressure,
      this.groundLevelPressure});

  factory MainViewModel.fromJson(Map<String, dynamic> jsonData) {
    return MainViewModel(
      temp: jsonData['temp'],
      feelsLike: jsonData['feels_like'],
      pressure: jsonData['pressure'],
      humidity: jsonData['humidity'],
      minimumTemperature: jsonData['temp_min'],
      maximumTemperature: jsonData['temp_max'],
      groundLevelPressure: jsonData['grnd_level'],
      seaLevelPressure: jsonData['sea_level'],
    );
  }
}
