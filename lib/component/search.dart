import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String placeholder;
  final Function(String) onChanged;

  const Search({Key? key, required this.onChanged, required this.placeholder}) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.placeholder,
                border: InputBorder.none,
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}