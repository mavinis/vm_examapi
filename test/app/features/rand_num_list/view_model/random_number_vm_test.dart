import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vm_examapi/api/exam_api.dart';
import 'package:vm_examapi/app/features/rand_num_list/view_model/rand_num_list_vm.dart';

class MockExamApi extends Mock implements ExamApi {}

class MockCallback extends Mock {
  void call();
}

void main() {
  late MockExamApi mockExamApi;
  late RandNumListViewModel viewModel;

  setUp(() {
    mockExamApi = MockExamApi();
    viewModel = RandNumListViewModel(mockExamApi);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('NumberListViewModel.getRandomNumbers', () {
    const count = 5;
    final randomNumbers = [1, 4, 3, 5, 2];

    setUp(() {
      when(() => mockExamApi.getRandomNumbers(any())).thenReturn(randomNumbers);
    });

    test('chama ExamApi.getRandomNumbers uma vez', () async {
      viewModel.getRandomNumbers(count);
      verify(() => mockExamApi.getRandomNumbers(count)).called(1);
    });

    test('atualiza `numbers` com o resultado de ExamApi.getRandomNumbers',
        () async {
      viewModel.getRandomNumbers(count);
      expect(viewModel.numbers, randomNumbers);
    });

    test('notifica os listeners', () {
      final listener = MockCallback();
      viewModel.addListener(listener.call);
      viewModel.getRandomNumbers(count);
      verify(listener.call).called(1);
    });
  });

  group('NumberListViewModel.reorderNumbers', () {
    const count = 5;
    final randomNumbers = [1, 3, 2, 4, 5];

    setUp(() {
      when(() => mockExamApi.getRandomNumbers(any())).thenReturn(randomNumbers);
      viewModel.getRandomNumbers(count);
    });

    test('reordena `numbers` de acordo com os índices fornecidos', () {
      viewModel.reorderItem(1, 3);
      expect(viewModel.numbers, [1, 2, 3, 4, 5]);
      viewModel.reorderItem(2, 1);
      expect(viewModel.numbers, [1, 3, 2, 4, 5]);
    });

    test('chama ExamApi.checkOrder uma vez', () async {
      viewModel.reorderItem(1, 3);
      verify(() => mockExamApi.checkOrder(any())).called(1);
    });

    test('atualiza `isAscendingOrder` corretamente', () {
      when(() => mockExamApi.checkOrder(any())).thenReturn(true);
      viewModel.reorderItem(1, 3);
      expect(viewModel.isAscendingOrder, true);
      when(() => mockExamApi.checkOrder(any())).thenReturn(false);
      viewModel.reorderItem(2, 1);
      expect(viewModel.isAscendingOrder, false);
    });

    test('notifica os listeners', () {
      final listener = MockCallback();
      viewModel.addListener(listener.call);
      viewModel.reorderItem(1, 3);
      verify(listener.call).called(1);
    });
  });
}
