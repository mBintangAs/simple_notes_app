import 'package:flutter/material.dart';
import 'package:simple_notes_app/pages/edit_notes.dart';

class EnterPassword extends StatefulWidget {
  final String pin;
  final int id;
  const EnterPassword({super.key, required this.pin, required this.id});

  @override
  State<EnterPassword> createState() => EnterPasswordState();
}

class EnterPasswordState extends State<EnterPassword> {
  final password = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Masukkan Password"),
      content: TextFormField(
        autofocus: true,
        obscureText: obscureText,
        controller: password,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Batal'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            if (widget.pin == password.text) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditNotes(id: widget.id)));
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text("Password Salah"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("oke"))
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
