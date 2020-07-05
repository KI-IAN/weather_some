import 'package:sqflite/sqflite.dart';
import 'package:weather_some/Pages/AddLocation/ViewModels/LocationViewModel.dart';
import 'package:weather_some/Repository/WeatherSomeDBContext.dart';

class LatestWeatherPageHelper {
  Database _dbContext;

  Future<LocationViewModel> getSelectedLocation() async {
    _dbContext = await WeatherSomeDBContext().initializeDatabase();

    var query = '''
Select * from savedLocation 
where isSelectedCity = 1
LIMIT 1;
''';

    List<Map<String, dynamic>> data = await _dbContext.rawQuery(query);

    var list = List.generate(
        data.length,
        (index) => () {
              return LocationViewModel(
                id: data.elementAt(index)['id'],
                cityName: data.elementAt(index)['cityName'],
                countryCode: data.elementAt(index)['countryCode'],
                isDeleteable: data.elementAt(index)['isDeleteable'],
                isSelectedCity: data.elementAt(index)['isSelectedCity'],
                latitude: data.elementAt(index)['latitude'],
                longitude: data.elementAt(index)['longitude'],
              );
            });

    return list.first();
  }
}
