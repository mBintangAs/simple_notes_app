import 'package:flutter/material.dart';
import 'package:simple_notes_app/component/notes_card.dart';
import 'package:simple_notes_app/component/search.dart';
import 'package:simple_notes_app/pages/add_notes.dart';
import 'package:simple_notes_app/pages/edit_notes.dart';
import 'package:simple_notes_app/service/database_helper.dart';
import 'package:simple_notes_app/service/notes.dart';

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
      final notes = await allNotes();
      setState(() {
        _notes = notes;
      });
    } catch (e) {
      // Handle error gracefully
      print('Error fetching data: $e');
    }
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
          Search(onChanged: (value) => {print(value)}, placeholder: "Search"),
          Expanded(
            flex: 1,
              child: ListView(
            children: _notes
                .map((value) => InkWell(
                  onTap: () =>  Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>  EditNotes(id: value['id'])))
              ,
                  child: NotesCard(
                      judul: value['judul'],
                      tanggal: parseDate(value['tanggal']),
                      isi: value['isi']),
                ))
                .toList(),
          )),
        ]),
      ),
    );
  }
}
