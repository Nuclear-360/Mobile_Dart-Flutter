import '../models/cartao_mito.dart';
import '../models/pergunta.dart';
import '../models/referencia.dart';

/// Resultado exibido após cada resposta: acerto, explicação e fontes.
class ResultadoResposta {
  const ResultadoResposta({
    required this.acertou,
    required this.explicacao,
    required this.referencias,
    required this.xpGanho,
  });

  final bool acertou;
  final String explicacao;
  final List<Referencia> referencias;
  final int xpGanho;
}

/// Correção das respostas. Hoje roda no app com dados mockados; na
/// Sprint 2 a correção passa para o servidor (evita fraude no ranking).
class QuizService {
  const QuizService();

  ResultadoResposta responderPergunta(
    Pergunta pergunta,
    String alternativaId, {
    int xp = 10,
  }) {
    final acertou = pergunta.correta.id == alternativaId;
    return ResultadoResposta(
      acertou: acertou,
      explicacao: pergunta.explicacao,
      referencias: pergunta.referencias,
      xpGanho: acertou ? xp : 0,
    );
  }

  ResultadoResposta responderCartao(
    CartaoMito cartao, {
    required bool usuarioDisseVerdade,
    int xp = 5,
  }) {
    final acertou = cartao.ehVerdade == usuarioDisseVerdade;
    return ResultadoResposta(
      acertou: acertou,
      explicacao: cartao.explicacao,
      referencias: cartao.referencias,
      xpGanho: acertou ? xp : 0,
    );
  }
}
