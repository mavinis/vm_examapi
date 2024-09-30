import 'package:flutter/material.dart';

import '../../rand_num_list/ui/rand_num_list_page.dart';
import 'components/item_count_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamApp'),
        centerTitle: true,
      ),
      body: _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 124.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calculate_outlined,
            size: 160,
            color: Theme.of(context).colorScheme.primaryFixedDim,
          ),
          Text(
            'Gere números aleatórios e organize-os em ordem crescente.',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(),
            textAlign: TextAlign.center,
          ),
          Text(
            'Toque no botão "Gerar números" para começar.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60.0),
          _RandNumGeneratorButton(),
        ],
      ),
    );
  }
}

class _RandNumGeneratorButton extends StatelessWidget {
  const _RandNumGeneratorButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: const Text('Gerar números'),
      icon: const Icon(Icons.auto_awesome),
      style: ElevatedButton.styleFrom(
        elevation: 4,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        minimumSize: Size(200.0, 56.0),
      ),
      onPressed: () async {
        int? count = await showDialog<int>(
          context: context,
          builder: (context) => ItemCountDialog(),
        );
        if (count != null && context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RandNumListPage(count: count),
            ),
          );
        }
      },
    );
  }
}
