class WeatherViewModel {
  ///Weather condition id
  num id;

  ///Group of weather parameters (Rain, Snow, Extreme etc.)
  String main;

  ///Weather condition within the group. You can get the output in
  String description;

  ///Weather icon id
  String icon;

  WeatherViewModel({this.id, this.main, this.description, this.icon});

  factory WeatherViewModel.fromJson(List<dynamic> jsonData) {
    return WeatherViewModel(
      id: jsonData.elementAt(0)['id'],
      main: jsonData.elementAt(0)['main'],
      description: jsonData.elementAt(0)['description'],
      icon: jsonData.elementAt(0)['icon'],
    );
  }
}
