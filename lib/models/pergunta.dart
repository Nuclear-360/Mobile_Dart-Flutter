import 'alternativa.dart';
import 'enums.dart';
import 'referencia.dart';

/// Pergunta de múltipla escolha de uma missão do tipo quiz.
class Pergunta {
  const Pergunta({
    required this.id,
    required this.missaoId,
    required this.enunciado,
    required this.alternativas,
    required this.explicacao,
    required this.referencias,
    this.status = StatusCuradoria.aprovada,
  });

  final String id;
  final String missaoId;
  final String enunciado;
  final List<Alternativa> alternativas;
  final String explicacao;
  final List<Referencia> referencias;
  final StatusCuradoria status;

  /// Regra central do produto: sem aprovação e sem fonte, não aparece.
  bool get publicavel =>
      status == StatusCuradoria.aprovada && referencias.isNotEmpty;

  Alternativa get correta => alternativas.firstWhere((a) => a.correta);
}
