import 'package:flutter/material.dart';

class EditJudul extends StatefulWidget {
  final TextEditingController judul;
  final bool isEdit;
  const EditJudul({super.key, required this.judul, required this.isEdit});

  @override
  State<EditJudul> createState() => _EditJudulState();
}

class _EditJudulState extends State<EditJudul> {
  TextEditingController judul = TextEditingController();
  @override
  void initState() {
    super.initState();
    judul = widget.judul;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isEdit
        ? TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,),
            controller: judul,
          )
        : Text(judul.text);
  }
}
