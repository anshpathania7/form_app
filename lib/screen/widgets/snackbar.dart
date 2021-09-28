import 'package:flutter/material.dart';

class Snackbar extends SnackBar {
  final String message;
  Snackbar({Key? key, required this.message})
      : super(
          key: key,
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
}
