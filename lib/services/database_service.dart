import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'fittrack.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE workouts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            setCount INTEGER,
            reps INTEGER,
            weight REAL,
            tanggal TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE body_weight(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            weight REAL,
            date TEXT
          )
        ''');
      },
    );
  }
}