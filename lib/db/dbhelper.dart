import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<Database> database() async {
    final datapath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(datapath, 'image.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_image(id TEXT PRIMARY KEY, title TEXT, image TEXT, story TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper.database();
    return db.query(table);
  }
}
