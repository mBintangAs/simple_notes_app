import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

Future allNotes() async {
  var db = await openDatabase('my_db.db');
  var notes = await db.rawQuery("SELECT id,isi,judul,tanggal FROM notes WHERE is_deleted = 'false'");
  return notes;
}

Future findNotesById(int id) async {
  var db = await openDatabase('my_db.db');
  var notes = await db.query("notes", where: "id = $id");
  return notes.first;
}

Future<List<Map<String, dynamic>>> findNotesByQuery(String search) async {
  var db = await openDatabase('my_db.db');
  var notes = await db.rawQuery(
      "SELECT * FROM notes WHERE is_deleted = 'false' AND (judul LIKE '%$search%' OR isi LIKE '%$search%')");
  return notes;
}


Future deleteNotes(id) async {
  var db = await openDatabase('my_db.db');
  return await db.update("notes", {"is_deleted": "true"}, where: "id = $id");
}


Future undoDeleteNotes(id) async {
  var db = await openDatabase('my_db.db');
  return await db.update("notes", {"is_deleted": "false"}, where: "id = $id");
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

Future<void> updateNotes(isi, id, [judul]) async {
  if (isi != '') {
    var db = await openDatabase('my_db.db');

    await db.update(
        'notes',
        {
          'isi': isi,
          'tanggal': DateTime.now().toString(),
          'judul': judul ?? DateTime.now().toString(),
        },
        where: "id = $id");
  }
}

String parseDate(date) {
  return DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(date)).toString();
}
