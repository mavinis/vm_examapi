import 'package:flutter/material.dart';

class GenericErrorDialog extends StatelessWidget {
  const GenericErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Erroro'),
      content: Text('Um erro inesperado aconteceu.'),
      actions: <Widget>[
        TextButton(
          child: Text('Voltar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
