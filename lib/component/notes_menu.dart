import 'package:flutter/material.dart';
import 'package:simple_notes_app/component/set_password.dart';

class NotesMenu extends StatefulWidget {
  final VoidCallback delete;
  final VoidCallback fetchData;
  final int id;
  final String pin;
  const NotesMenu({
    super.key,
    required this.delete,
    required this.fetchData,
    required this.id,
    required this.pin,
  });

  @override
  State<NotesMenu> createState() => _NotesMenuState();
}

class _NotesMenuState extends State<NotesMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 20 / 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              widget.delete();
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: const [
                  Icon(Icons.delete),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Hapus"),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => SetPassword(id: widget.id,fetchData: widget.fetchData,)
                  );
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: [
                  Icon(widget.pin != "" ? Icons.lock_open : Icons.lock),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: widget.pin != ""
                        ? const Text("Buka Kunci")
                        : const Text("Kunci"),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: const [
                  Icon(Icons.visibility_off),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Sembunyikan"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
