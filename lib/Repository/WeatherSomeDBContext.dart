import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WeatherSomeDBContext {
  static String dbName = 'weather_some.db';
  static int version = 1;

static String savedLocationTableCreateQuery = '''CREATE TABLE "savedLocation" (
	"id"	INTEGER NOT NULL UNIQUE,
	"cityName"	TEXT NOT NULL,
	"countryCode"	TEXT NOT NULL,
	"latitude"	TEXT NOT NULL,
	"longitude"	TEXT NOT NULL,
	"stateCode"	TEXT,
	"isDeleteable"	INTEGER NOT NULL DEFAULT 1,
	"isSelectedCity"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("id" AUTOINCREMENT)
)''';


static String locationDateInsertStatement = '''Insert Into "savedLocation"("cityName", "countryCode", "latitude", "longitude", "isDeleteable", "isSelectedCity")
VALUES
("Kuala Lumpur", "MY", "3.14", "101.69", 0, 1),
("George Town", "MY", "5.411229", "100.335426", 0, 0),
("Johor Bahru", "MY", "1.4655", "103.7578", 0, 0);
 ''';



  Future<Database> initializeDatabase() async {
    final database = openDatabase(join(await getDatabasesPath(), dbName),
        onCreate: (db, version) {
          db.execute(savedLocationTableCreateQuery);
          db.execute(locationDateInsertStatement);
        },
        version: version);

    return database;
  }
}
