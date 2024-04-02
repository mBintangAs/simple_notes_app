import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

Future allNotes() async {
  var db = await openDatabase('my_db.db');
  var notes = await db.query("notes", orderBy: 'id DESC');
  return notes;
}

Future insertNotes(isi, [judul]) async {
  if (isi != '') {
    var db = await openDatabase('my_db.db');

    await db.insert('notes', {
      'isi': isi,
      'tanggal': DateTime.now().toString(),
      'judul': judul ?? DateTime.now().toString(),
    });
  }
}

String parseDate(date) {
  return DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(date)).toString();
}
