import 'package:flutter/material.dart';

void showAscendingOrderBanner(BuildContext context) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      content: Text(
        'Os números estão em ordem crescente!',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      leading: Icon(Icons.celebration_rounded),
      backgroundColor: Colors.green,
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: Text('Dispensar'),
        ),
      ],
    ),
  );
}

void showWrongOrderBanner(BuildContext context) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      content: Text(
        'Parece que algum número está fora de ordem...',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      leading: Icon(Icons.compare_arrows_rounded),
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: Text('Dispensar'),
        ),
      ],
    ),
  );
}
