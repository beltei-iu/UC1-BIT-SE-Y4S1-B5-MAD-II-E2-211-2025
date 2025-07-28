import 'package:flutter/material.dart';

class SnackBarWidget {
  final String error;

  SnackBarWidget(this.error);

  Widget buildSnackBar() {
    return SnackBar(
      content: Text(error.toString()),
      backgroundColor: Colors.red,
    );
  }
}
