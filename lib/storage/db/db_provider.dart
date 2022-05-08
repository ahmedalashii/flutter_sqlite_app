import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final DbProvider _instance = DbProvider._internal();
  late Database _database;

  DbProvider._internal();

  factory DbProvider() {
    return _instance;
  }

  Database get database => _database;

  Future<void> initDB() async {
    Directory directory =
        await getApplicationDocumentsDirectory(); // مسار حفظ الملفات
    String path = join(directory.path,
        "app_db.sql"); //  join('path', 'to', 'foo'); // -> 'path/to/foo' >> first part is the directory and the second is the name of the database
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (Database db) {},
      onCreate: (Database db, int version) async {
        db.execute("CREATE TABLE IF NOT EXISTS notes ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "content TEXT" // text not varchar2 :)
            ")");
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {},
      onDowngrade: (Database db, int oldVersion, int newVersion) {},
    );
  }
}
