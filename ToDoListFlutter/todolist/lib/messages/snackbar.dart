import 'package:flutter/material.dart';

snackBarSuccessWidget(context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        text,
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

snackBarErrorWidget(context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red[200],
      content: Text(
        text,
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
