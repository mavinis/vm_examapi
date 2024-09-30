import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../../../api/exam_api.dart';

// Como o App não executa chamadas remotas, realiza poucas operações assíncronas,
// e depende de poucos pacotes externos, as chances de uma chamada resultar
// em `Exception` é bastante baixa.
//
// A maioria dos `Erros` que ocorrem são causados por falhas no código,
// ou por situações que podem ser evitadas por meio de validações e restrições
// na interface.
//
// Nesses casos, prefiro trabalhar com `asserts`, que alertam o desenvolvedor
// de possíveis brechas que podem ser contornadas em fase de desenvolvimento,
// sem chegar à produção.
//
// Neste ViewModel implementei um tratamento de erros bastante básico, apenas
// para simular situações em que o App poderia estar vulnerável.

/// ViewModel para gerenciar a lista reordenável de números aleatórios.
class RandNumListViewModel extends ChangeNotifier {
  final ExamApi _examApi;
  RandNumListViewModel(ExamApi examApi) : _examApi = examApi;

  List<int> _numbers = [];
  bool _isAscendingOrder = false;
  Object? _failure;

  /// Retorna a lista de números aleatórios.
  List<int> get numbers => _numbers;

  /// Indica se os números na lista estão em ordem crescente.
  bool get isAscendingOrder => _isAscendingOrder;

  /// Retorna o erro ocorrido, se houver.
  Object? get failure => _failure;

  /// Preenche a lista com a quantidade de números aleatórios solicitada.
  void getRandomNumbers(int count) {
    assert(count >= 2, '`count` deve ser >= 2');
    try {
      _numbers = _examApi.getRandomNumbers(count);
    } catch (e, stack) {
      _failure = e;
      if (kDebugMode) log(e.toString(), error: e, stackTrace: stack);
    } finally {
      notifyListeners();
    }
  }

  /// Reordena um item na lista.
  void reorderItem(int oldIndex, int newIndex) {
    assert(numbers.length >= 2,
        '`numbers` deve conter ao menos 2 itens para reordenar');
    assert(oldIndex >= 0 && oldIndex < numbers.length,
        '`oldIndex` inválido para `numbers`');
    assert(newIndex >= 0 && newIndex <= numbers.length,
        '`newIndex` inválido para `numbers`');
    try {
      if (oldIndex < newIndex) {
        // Quando um item é movido de uma posição menor para uma maior,
        // o índice final sofre um ajuste de -1 devido à reorganização
        // dos demais elementos da lista
        newIndex -= 1;
      }
      final item = _numbers.removeAt(oldIndex);
      _numbers.insert(newIndex, item);
      _isAscendingOrder = _examApi.checkOrder(_numbers);
    } catch (e, stack) {
      _failure = e;
      if (kDebugMode) log(e.toString(), error: e, stackTrace: stack);
    } finally {
      notifyListeners();
    }
  }
}
