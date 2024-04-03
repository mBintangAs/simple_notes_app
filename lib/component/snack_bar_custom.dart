import 'package:flutter/material.dart';

class SnackBarCustom extends SnackBar {
  final Function() onPress;

  SnackBarCustom({super.key, required this.onPress})
      : super(
            content: const Text('Item Terhapus',style: TextStyle(color: Colors.white),),
            action: SnackBarAction(label: 'Batal', onPressed: onPress),
            backgroundColor: Colors.black,
            
            );
}
