import 'package:flutter/material.dart';
import 'package:simple_notes_app/component/enter_password.dart';
import 'package:simple_notes_app/component/notes_card.dart';
import 'package:simple_notes_app/component/notes_menu.dart';
import 'package:simple_notes_app/component/search.dart';
import 'package:simple_notes_app/component/snack_bar_custom.dart';
import 'package:simple_notes_app/component/swipe_detector.dart';
import 'package:simple_notes_app/pages/add_notes.dart';
import 'package:simple_notes_app/pages/edit_notes.dart';
import 'package:simple_notes_app/service/notes.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({super.key, required this.title});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List _notes = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future _fetchData() async {
    try {
      final notesData = await allNotes();
      setState(() {
        _notes = notesData;
      });
    } catch (e) {
      // Handle error gracefully
      print('Error fetching data: $e');
    }
  }

  void searchNote(value) async {
    if (value != null) {
      final notes = await findNotesByQuery(value);
      if (notes.isNotEmpty) {
        setState(() {
          _notes = notes;
        });
      }
    } else {
      _fetchData();
    }
  }

  void deleteNote(context, id) async {
    await deleteNotes(id);
    await _fetchData();
    final snackbar = SnackBarCustom(onPress: () async {
      await undoDeleteNotes(id);
      await _fetchData();
    });
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const AddNotes()))
              },
          backgroundColor: const Color.fromARGB(255, 86, 86, 86),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.title,
            style: const TextStyle(
                fontSize: 32, fontFamily: "Arial", fontWeight: FontWeight.bold),
          ),
          const Divider(height: 30),
          Search(
              onChanged: (value) => {searchNote(value)}, placeholder: "Search"),
          Expanded(
              flex: 1,
              child: ListView(
                children: _notes
                    .map((value) => InkWell(
                          onLongPress: () {
                            showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => NotesMenu(
                                    delete: () =>
                                        deleteNote(context, value['id']),
                                    fetchData: _fetchData,
                                    id: value['id'],
                                    pin: value['pin']??"",
                                    ),
                                expand: false,
                                enableDrag: true);
                          },
                          onTap: () {
                            value['pin'] != null
                                ? showDialog(
                                    context: context,
                                    builder: (context) => EnterPassword(id: value['id'],pin: value['pin']))
                                : 
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditNotes(id: value['id'])));
                          },
                          child: SwipeDetector(
                            key: UniqueKey(),
                            onSwipeLeft: () {
                              deleteNote(context, value['id']);
                            },
                            onSwipeRight: () {
                              deleteNote(context, value['id']);
                            },
                            child: NotesCard(
                                judul: value['judul'],
                                tanggal: parseDate(value['tanggal']),
                                isi: value['isi'],
                                pin: value['pin'] ?? ""),
                          ),
                        ))
                    .toList(),
              )),
        ]),
      ),
    );
  }
}
