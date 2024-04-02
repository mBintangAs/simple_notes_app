import 'package:flutter/material.dart';
import 'package:simple_notes_app/component/edit_judul.dart';
import 'package:simple_notes_app/pages/home.dart';
import 'package:simple_notes_app/service/notes.dart';
import 'package:intl/intl.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _isi = TextEditingController();
  final _judul = TextEditingController();
  bool isEdit = false;
  void saveBack() {
    insertNotes(_isi.text, _judul.text);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Home(
                  title: "NotesApp",
                )));
  }

  void setEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  @override
  void initState() {
    super.initState();
    _judul.text = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: EditJudul(
          judul: _judul,
          isEdit: isEdit,
        ),
        centerTitle: true,
        actions: [
          isEdit
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () => setEdit(), child: const Icon(Icons.save)),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () => setEdit(), child: const Icon(Icons.edit)),
                )
        ],
        leading: InkWell(
          onTap: () => {saveBack()},
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          controller: _isi,
          maxLines: null,
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: "Masukkan Text"),
        ),
      ),
    );
  }
}
