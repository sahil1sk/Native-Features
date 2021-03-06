import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

// so this class is used in providers/great_places.dart file
class DBHelper {
  // returning sql database
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath(); // getDatabasesPath give us the right path where we store data

    // here we open the data base by providing the path and file name if the file exists then it will use it 
    return sql.openDatabase(
      path.join(dbPath, 'places.db'), 
      onCreate: (db, version) { // if the file not find then onCreate method take place
      // db is the database and version is the current version // type text or string // REAL help to store decimal value
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1); // we also able to set version everytime
  }

  // static method so that we would use without intiating
  static Future<void> insert(
    String table, Map<String, Object> data
  ) async {
    
    // getting the database
    final db = await DBHelper.database();
    // inserting the data in db
    db.insert(
      table, 
      data, 
      conflictAlgorithm: sql.ConflictAlgorithm.replace // means if insert over the id which is exists then overrid that
    );
  } 

  // returning the list of maps
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    // inserting the data in db
    final db = await DBHelper.database();
    return db.query(table);
  }
}