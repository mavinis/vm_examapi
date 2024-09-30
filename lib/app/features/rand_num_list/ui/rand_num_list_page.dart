import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vm_examapi/api/exam_api.dart';

import '../view_model/rand_num_list_vm.dart';
import 'components/generic_error_dialog.dart';
import 'components/order_validation_banner.dart';

class RandNumListPage extends StatelessWidget {
  final int count;
  const RandNumListPage({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return RandNumListViewModel(ExamApi())..getRandomNumbers(count);
      },
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Reordenador'),
            centerTitle: true,
          ),
          body: const _RandomNumberListView(),
          floatingActionButton: _CheckOrderButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

class _RandomNumberListView extends StatefulWidget {
  const _RandomNumberListView();

  @override
  State<_RandomNumberListView> createState() => _RandomNumberListViewState();
}

class _RandomNumberListViewState extends State<_RandomNumberListView> {
  @override
  void initState() {
    context.read<RandNumListViewModel>().addListener(_showErrorDialog);
    super.initState();
  }

  _showErrorDialog() async {
    if (context.read<RandNumListViewModel>().failure != null) {
      await showDialog<int>(
        context: context,
        builder: (context) => GenericErrorDialog(),
      );
      final currContext = context;
      if (currContext.mounted) Navigator.of(currContext).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RandNumListViewModel>(
      builder: (context, viewModel, child) {
        return ReorderableListView.builder(
          header: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              'Segure e arraste os itens para reordená-los em ordem crescente.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: viewModel.numbers.length,
          itemBuilder: (context, index) {
            final number = viewModel.numbers[index];
            return ListTile(
              key: ValueKey(number),
              title: Text('$number'),
              trailing: const Icon(Icons.drag_handle),
              onTap: () {}, // Apenas para habilitar o efeito do InkWell
            );
          },
          proxyDecorator: (child, index, animation) {
            return Material(
              elevation: 3.0,
              surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
              child: child,
            );
          },
          onReorder: (oldIndex, newIndex) {
            viewModel.reorderItem(oldIndex, newIndex);
            if (viewModel.isAscendingOrder) {
              showAscendingOrderBanner(context);
            } else {
              ScaffoldMessenger.of(context).clearMaterialBanners();
            }
          },
        );
      },
    );
  }
}

class _CheckOrderButton extends StatelessWidget {
  const _CheckOrderButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: FloatingActionButton.extended(
        label: const Text('Validar ordem dos números'),
        icon: const Icon(Icons.check),
        onPressed: () async {
          if (context.read<RandNumListViewModel>().isAscendingOrder) {
            ScaffoldMessenger.of(context).clearMaterialBanners();
            showAscendingOrderBanner(context);
          } else {
            ScaffoldMessenger.of(context).clearMaterialBanners();
            showWrongOrderBanner(context);
          }
        },
      ),
    );
  }
}
