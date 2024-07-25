import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../repositories/login/models/my_user.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  //tables
  static String _usersTableName = "users";
  static String _userIdColumnName = 'id';
  static String _userEmailColumnName = 'email';
  static String _userPasswordColumnName = 'password';

  DatabaseService._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute("""
            CREATE TABLE $_usersTableName (
              $_userIdColumnName TEXT PRIMARY KEY,
              $_userEmailColumnName TEXT NOT NULL,
              $_userPasswordColumnName TEXT
            )
      """);
      },
    );
    return database;
  }

  Future<void> addUser(MyUser myUser) async {
    final Database db = await database;
    await db.insert(
      _usersTableName,
      myUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteExistingDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'master_db.db');
    await deleteDatabase(databasePath);
    print("Deleted");
  }
}
