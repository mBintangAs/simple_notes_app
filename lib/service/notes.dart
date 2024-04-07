import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

Future allNotes() async {
  var db = await openDatabase('my_db.db');
  var notes = await db.rawQuery(
      "SELECT * FROM notes WHERE is_deleted = 'false' AND is_hide ='false' ORDER BY tanggal DESC");
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

Future<String> lockNotes(id, pin) async {
  var db = await openDatabase('my_db.db');
   var data = await db.query('notes', where: "id = ?", whereArgs: [id]);
  if(data.first['pin']==null){
      await db.update('notes', {"pin": pin}, where: "id = ?", whereArgs: [id]);
      return "Password berhasil di tambahkan";
  }
  if (data.first['pin']==pin) {
      await db.update('notes', {"pin": null}, where: "id = ?", whereArgs: [id]);
      return "Password berhasil di hapus";
  }else{
      return "Password salah";
  }
}

String parseDate(date) {
  return DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(date)).toString();
}
