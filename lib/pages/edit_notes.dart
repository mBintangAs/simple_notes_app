import 'package:flutter/material.dart';
import 'package:simple_notes_app/component/edit_judul.dart';
import 'package:simple_notes_app/pages/home.dart';
import 'package:simple_notes_app/service/notes.dart';

class EditNotes extends StatefulWidget {
  final int id;
  const EditNotes({super.key, required this.id});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final _isi = TextEditingController();
  final _judul = TextEditingController();
  bool isEdit = false;
  void saveBack() {
    updateNotes(_isi.text,widget.id, _judul.text);
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

  Future getNotes() async {
    final note = await findNotesById(widget.id);
    
    setState(() {
      _isi.text= note['isi'];
      _judul.text= note['judul'];
    });
  }
  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        saveBack();
        return true;
      },
      child: Scaffold(
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
      ),
    );
  }
}
