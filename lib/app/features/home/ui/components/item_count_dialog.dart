import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemCountDialog extends StatelessWidget {
  ItemCountDialog({super.key});
  final formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Gerar números aleatórios'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quantos números deseja gerar?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            key: formKey,
            autofocus: true,
            decoration: InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório';
              }
              final number = int.tryParse(value);
              if (number == null) {
                return 'Insira um número inteiro válido';
              }
              if (number < 2) {
                return 'A quantidade mínima é 2 números';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState!.save();
              }
            },
            onSaved: (value) {
              final int count = int.parse(value!);
              Navigator.pop(context, count);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              formKey.currentState!.save();
            }
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
