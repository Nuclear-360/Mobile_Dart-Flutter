/// Item de quiz unificado: serve tanto para os dados vindos da API Java
/// quanto para os dados mockados, para as telas não precisarem saber a origem.
class QuizItem {
  const QuizItem({
    required this.enunciado,
    required this.alternativas,
    required this.explicacao,
    required this.fonte,
  });

  final String enunciado;
  final List<QuizAlternativa> alternativas;
  final String explicacao;

  /// De onde veio o conteúdo (ex.: "Backend Nuclear 360 (API)" ou "CNEN").
  final String fonte;

  int get indiceCorreta => alternativas.indexWhere((a) => a.correta);
}

class QuizAlternativa {
  const QuizAlternativa({required this.texto, required this.correta});

  final String texto;
  final bool correta;
}
