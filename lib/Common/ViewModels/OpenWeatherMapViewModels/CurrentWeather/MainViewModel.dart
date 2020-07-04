class MainViewModel {
  ///Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  num temp;

  ///Temperature. This temperature parameter accounts for the human
  num feelsLike;

  ///Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
  num pressure;

  ///Humidity, %
  num humidity;

  ///Minimum temperature at the moment. This is minimal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  num minimumTemperature;

  ///Maximum temperature at the moment. This is maximal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  num maximumTemperature;

  ///Atmospheric pressure on the sea level, hPa
  num seaLevelPressure;

  ///Atmospheric pressure on the ground level, hPa
  num groundLevelPressure;

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
