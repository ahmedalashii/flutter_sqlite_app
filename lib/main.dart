// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';
import 'screens/add_note_screen.dart';
import 'screens/launch_screen.dart';
import 'screens/main_screen.dart';
import 'storage/db/db_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbProvider().initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<Something>(create: (_) => Something()),
        ChangeNotifierProvider<NoteProvider>(create: (_) => NoteProvider()),
      ],
      child: MyMaterialApp(),
    );
  }
}
class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/launch_screen",
      routes: {
        "/launch_screen": (context) => LaunchScreen(),
        "/main_screen": (context) => MainScreen(),
        "/add_note_screen": (context) => AddNoteScreen(),
      },
    );
  }
}

