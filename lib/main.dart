import 'package:flutter/material.dart';
import 'package:simple_notes_app/pages/home.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  runApp(const MyApp());
  
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'my_db.db');
  final database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      return db.execute(
        "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,isi TEXT,judul TEXT,tanggal DATETIME);",
      );
    },
  );
  // // print(await getDatabasesPath());

  // await database.delete('notes');
  // await db.execute("CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT,isi TEXT,judul TEXT,tanggal DATETIME);");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const Home(title: "NotesApp"),
    );
  }
}
