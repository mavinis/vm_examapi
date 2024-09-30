import 'package:flutter_test/flutter_test.dart';
import 'package:vm_examapi/api/exam_api.dart';

void main() {
  late ExamApi api;

  setUp(() {
    api = ExamApi();
  });

  group('ExamApi.getRandomNumbers', () {
    test('lança RangeError para count fora do intervalo suportado', () {
      expect(() => api.getRandomNumbers(-1), throwsRangeError);
      expect(() => api.getRandomNumbers(1000), throwsRangeError);
    });

    test('retorna a quantidade de itens correta', () {
      final count = 10;
      final numbers = api.getRandomNumbers(count);
      expect(numbers.length, count);
    });

    test('retorna apenas valores únicos', () {
      final numbers = api.getRandomNumbers(10);
      expect(numbers.toSet().length, numbers.length);
    });

    test('retorna lista embaralhada', () {
      final numbers = api.getRandomNumbers(10);
      expect(api.checkOrder(numbers), isFalse);
    });
  });

  group('ExamApi.checkOrder', () {
    test('retorna `true` para números em ordem crescente', () {
      final ascendingList = [1, 2, 3, 4, 5];
      expect(api.checkOrder(ascendingList), isTrue);
    });

    test('retorna `false` números não-ordenados em ordem crescente', () {
      final nonAscendingList = [5, 3, 4, 1, 2];
      expect(api.checkOrder(nonAscendingList), isFalse);
    });
  });
}
