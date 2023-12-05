// database_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'user.dart';

class DatabaseHelper {
  static late Database _database;

  static Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'example.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
    );
  }

  static Future<void> insertUser(User user) async {
    await _ensureDatabaseInitialized();

    await _database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteUser(int id) async {
    await _ensureDatabaseInitialized();

    await _database.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<User>> getUsers() async {
    await _ensureDatabaseInitialized();

    final List<Map<String, dynamic>> maps = await _database.query('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  static Future<void> _ensureDatabaseInitialized() async {
    if (!(_database.isOpen)) {
      await initDatabase();
    }
  }
}
