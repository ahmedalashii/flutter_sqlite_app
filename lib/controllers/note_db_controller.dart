import 'package:sqflite/sqflite.dart';

import '../storage/db/db_operations.dart';
import '../storage/db/db_provider.dart';
import 'models/notes.dart';

class NoteDbController extends DbOperations<Note> {
  Database database = DbProvider().database;

  @override
  Future<int> createRow(Note object) async {
    int newRowId = await database.insert(
        "notes",
        object
            .toMap()); // 0 if it's failed and more than 1 if it's succeeded (simply it returns the inserted-row id).
    return newRowId;
  }

  @override
  Future<bool> deleteRow(int id) async {
    // IN SQL : DELETE FROM notes; // everything
    // IN SQL : DELETE FROM notes WHERE id = 1; // specific id
    int countOfDeletedRows = await database.delete(
      "notes",
      where: "id = ?",
      whereArgs: [id], // this is called attribute binding
    ); // بسرعة اتذكرلي هان شغل الداتا بيز اللي موجود بالداتا بيز ايام برمجة 3 :) يعني بعدد علامات الاستفهام لازم يكون في الـ whereArgs موجود arguments وبالترتيب
    // the line above will return the number of deleted rows.
    return (countOfDeletedRows >
        0); // if it's more than 0 >> delete operation is succeeded.
  }

  @override
  Future<List<Note>> getAllRows() async {
    // database.query("notes") ; // SELECT * FROM notes; // everything
    List<Map<String, Object?>> data = await database.query("notes");
    // First Way:
    List<Note> notes = data
        .map((Map<String, Object?> rowMap) => Note.fromMap(rowMap)) // Iterable
        .toList(); // Iterable to list >> here remember streams and collections in java 3 :)
    // Second Way :
    // List<Note> notes = <Note>[];
    // for(Map<String,Object?> rowMap in data){
    //   Note note  = Note.fromMap(rowMap);
    //   notes.add(note);
    // }
    return notes;
  }

  @override
  Future<Note?> getRow(int id) async {
    // SELECT * FROM notes WHERE id = 1; // specifics id
    List<Map<String, Object?>> data =
        await database.query("notes", where: "id = ?", whereArgs: [id]);
    if (data.isNotEmpty) {
      return Note.fromMap(data
          .first); // data is a list of maps so we need just one map which is one row.
    }
    return null;
  }

  @override
  Future<bool> updateRow(Note object) async {
    // IN SQL : UPDATE notes SET content = "NEW CONTENT"; // everything
    // IN SQL : UPDATE notes SET content = "NEW CONTENT" WHERE id = 1; // specific id

    int countOfUpdatedRows = await database.update("notes", object.toMap(),
        where: "id = ?", whereArgs: [object.id]);
    return (countOfUpdatedRows >
        0); // if it's more than 0 >> update operation is succeeded.
  }
}
