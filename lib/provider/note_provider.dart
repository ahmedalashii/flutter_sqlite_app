// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:sqlite_app/controllers/note_db_controller.dart';

import '../controllers/models/notes.dart';

// This Class is Like a SharedNotifier to represent a List<Note> for the different screens.
class NoteProvider extends ChangeNotifier {
  List<Note> notes = <Note>[];
  final NoteDbController _noteDbController = NoteDbController();

  Future<void> read() async {
    notes = await _noteDbController.getAllRows();
    notifyListeners();
  }

  Future<bool> create({required Note note}) async {
    int newRowId = await _noteDbController.createRow(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
      notifyListeners();
    }
    return (newRowId != 0);
  }

  Future<bool> update({required Note note}) async {
    bool updated = await _noteDbController.updateRow(note);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if (index != 0) {
        notes[index] = note;
        notifyListeners();
      }
    }
    return updated;
  }

  Future<bool> delete({required int id}) async{
      bool deleted = await _noteDbController.deleteRow(id);
      if (deleted){
        notes.removeWhere((element) => element.id == id);
        notifyListeners();
      }
      return deleted;
  }
}
