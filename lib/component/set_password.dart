import 'package:flutter/material.dart';
import 'package:simple_notes_app/service/notes.dart';

class SetPassword extends StatefulWidget {
  final int id;
  final VoidCallback fetchData;

  const SetPassword({super.key, required this.id, required this.fetchData});

  @override
  State<SetPassword> createState() => SetPasswordState();
}

class SetPasswordState extends State<SetPassword> {
  final password = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Atur Password"),
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
          onPressed: () async {
            String result = await lockNotes(widget.id, password.text);
            widget.fetchData();
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Text(result),
                      actions: [
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text("oke"))
                      ],
                    ));
          },
        ),
      ],
    );
  }
}
