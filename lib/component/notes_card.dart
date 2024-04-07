import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final String judul;
  final String tanggal;
  final String isi;
  final String pin;

  const NotesCard({
    Key? key,
    required this.judul,
    required this.tanggal,
    required this.isi,
    required this.pin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Card(
        child: DecoratedBox(
          decoration: const BoxDecoration(
            border: BorderDirectional(start: BorderSide(color: Colors.white38,width: 4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 50,
                      child: Text(
                        judul,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Text(
                        tanggal,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                pin==""?
                Text(
                  isi,
                  style: const TextStyle(fontSize: 16.0),
                  overflow: TextOverflow.ellipsis,
                ):const Icon(Icons.lock),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
