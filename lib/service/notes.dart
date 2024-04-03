import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

Future allNotes() async {
  var db = await openDatabase('my_db.db');
  var notes = await db.query("notes", orderBy: 'tanggal DESC');
  return notes;
}
Future findNotes(id) async {
  var db = await openDatabase('my_db.db');
  var notes = await db.query("notes",where: "id = $id");
  return notes.first;
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
