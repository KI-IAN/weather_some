import 'package:sqflite/sqflite.dart';
import 'package:weather_some/Repository/Models/SavedLocation.dart';
import 'package:weather_some/Repository/WeatherSomeDBContext.dart';

class SavedLocationRepository {
  String _tableName = 'savedLocation';

  Future<int> insert(SavedLocation savedLocation) async {
    final Database db = await WeatherSomeDBContext().initializeDatabase();

    return await db.insert(_tableName, savedLocation.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SavedLocation>> allSavedLocations() async {
    final Database db = await WeatherSomeDBContext().initializeDatabase();

    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (index) {
      return SavedLocation(
        id: maps[index]['id'],
        cityName: maps[index]['cityName'],
        countryCode: maps[index]['countryCode'],
        latitude: maps[index]['latitude'],
        longitude: maps[index]['longitude'],
        stateCode: maps[index]['stateCode'],
        isDeleteable: maps[index]['isDeleteable'],
        isSelectedCity: maps[index]['isSelectedCity'],
      );
    });
  }

  Future<int> update(SavedLocation dua) async {
    final Database db = await WeatherSomeDBContext().initializeDatabase();
    return await db
        .update(_tableName, dua.toMap(), where: 'id = ?', whereArgs: [dua.id]);
  }

  Future<int> delete(int id) async {
    final Database db = await WeatherSomeDBContext().initializeDatabase();
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
