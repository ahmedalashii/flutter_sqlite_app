// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_app/helpers/helpers.dart';

import '../provider/note_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with Helpers {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).read(); // it has to be false
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Notes",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
              onPressed: () => Navigator.pushNamed(context, "/add_note_screen"),
              icon: Icon(Icons.note_add)),
        ],
      ),
      body: Consumer<NoteProvider>(
        // to consume
        builder: (context, NoteProvider value, child) {
          if (value.notes.isEmpty) {
            // return Center(child: CircularProgressIndicator());
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Icon(Icons.warning, size: 80, color: Colors.grey.shade500),
                Text(
                  "NO DATA!",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ]),
            );
          } else {
            return ListView.builder(
                itemCount: value.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.note),
                    title: Text(value.notes[index].content),
                    trailing: IconButton(
                        onPressed: () async =>
                            deleteNote(id: value.notes[index].id),
                        icon: Icon(Icons.delete)),
                  );
                });
          }
        },
      ),
    );
  }

  Future<void> deleteNote({required int id}) async {
    bool deleted =
        await Provider.of<NoteProvider>(context, listen: false).delete(id: id);
    String message = (deleted) ? "Deleted Successfully" : "Deletion Failed!";
    showSnackBar(context: context, message: message, error: !deleted);
  }
}
