import 'dart:math';

import 'exam_api.dart';

class ExamApiImpl implements ExamApi {
  @override
  List<int> getRandomNumbers(int count, [int max = 999]) {
    // Alerta o desenvolvedor caso `count` não esteja no intervalo suportado.
    // Em vez de capturar e tratar este erro, o ideal é que o desenvolvedor
    // utilize validadores de input para evitá-lo no front end.
    if (count < 0 || count > max) throw RangeError.range(count, 0, max);

    // Set garante que todos os elementos sejam únicos
    final numberSet = <int>{};
    while (numberSet.length < count) {
      numberSet.add(Random().nextInt(max));
    }

    final numberList = numberSet.toList();

    while (checkOrder(numberList)) {
      // Caso os números sejam gerados em ordem crescente por coincidência,
      // este loop garante que a lista retornada estará embaralhada.
      numberList.shuffle();
    }

    return numberList;
  }

  @override
  bool checkOrder(List<int> numbers) {
    for (var i = 0; i < numbers.length - 1; i++) {
      if (numbers[i] > numbers[i + 1]) return false;
    }
    return true;
  }
}
