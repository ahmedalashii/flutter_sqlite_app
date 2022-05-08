// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/models/notes.dart';
import '../helpers/helpers.dart';
import '../provider/note_provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> with Helpers {
  late TextEditingController _contentTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentTextController = TextEditingController();
  }

  @override
  void dispose() {
    _contentTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Add Note",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: <Widget>[
          TextField(
            controller: _contentTextController,
            decoration: InputDecoration(hintText: "Enter Note Content"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => performSave(),
            child: Text("SAVE"),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 45),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performSave() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (_contentTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: "Enter Required Data", error: true);
    return false;
  }

  Future<void> save() async {
    bool created = await Provider.of<NoteProvider>(context, listen: false)
        .create(note: note);
    if (created) clear();
    String message = (created) ? "Created Successfully" : "Creation Failed!";
    showSnackBar(context: context, message: message, error: !created);
  }

  Note get note {
    Note newNote = Note();
    newNote.content = _contentTextController.text;
    return newNote;
  }

  void clear() {
    _contentTextController.text = "";
  }
}
