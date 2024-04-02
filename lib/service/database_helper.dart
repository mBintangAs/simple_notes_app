import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "my_db.db";
  static final _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // Jalankan perintah CREATE TABLE di sini
    db.execute("CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,isi TEXT,judul TEXT,tanggal DATETIME);");
  }
}