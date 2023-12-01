import 'package:flutter/material.dart';

Future<T?> showErrorDialog<T>(BuildContext context, String errorMessage) {
  return showDialog<T>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Feilmelding'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            child: const Text('LUKK'),
            onPressed: () async => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
