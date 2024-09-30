import 'exam_api_impl.dart';

/// Fornece métodos relacionadas a geração de números aleatórios
/// e verificação de ordem numérica crescente em listas.
abstract interface class ExamApi {
  factory ExamApi() => ExamApiImpl();

  /// Retorna uma lista de números aleatórios com
  /// a quantidade [count] de itens solicitada.
  ///
  /// Os números gerados terão valores entre 0 e [max].
  ///
  /// * [count] deve ser não-negativo menor ou igual a [max].
  /// * [max] deve estar no intervalo suportado pelo método Random().nextInt da
  /// biblioteca dart:math (entre 1 e (1<<32)).
  List<int> getRandomNumbers(int count, [int max = 999]);

  /// Verifica se uma lista de números informada
  /// está em ordem crescente e retorna o resultado.
  bool checkOrder(List<int> numbers);
}
