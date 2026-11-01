import '../models/quiz_item.dart';
import '../data/pergunta_api.dart';
import 'mock_data.dart';

/// De onde o quiz foi carregado, para a tela mostrar ao usuário.
enum OrigemQuiz { api, mock }

class ResultadoQuiz {
  const ResultadoQuiz(this.itens, this.origem);

  final List<QuizItem> itens;
  final OrigemQuiz origem;
}

/// Decide a fonte do quiz: tenta a API Java primeiro e, se ela estiver
/// fora do ar ou sem perguntas, cai no mock. Assim o protótipo sempre
/// funciona para a gravação, mesmo sem a API rodando.
class PerguntaRepository {
  const PerguntaRepository({this.api = const PerguntaApi()});

  final PerguntaApi api;

  Future<ResultadoQuiz> carregarQuiz() async {
    try {
      final itens = await api.buscarQuiz();
      if (itens.isNotEmpty) {
        return ResultadoQuiz(itens, OrigemQuiz.api);
      }
    } catch (_) {
      // API indisponível: segue para o mock.
    }
    return ResultadoQuiz(_quizMock(), OrigemQuiz.mock);
  }

  List<QuizItem> _quizMock() {
    return MockData.perguntas.map((p) {
      final fontes = p.referencias.map((r) => r.instituicao).join(', ');
      return QuizItem(
        enunciado: p.enunciado,
        alternativas: p.alternativas
            .map((a) => QuizAlternativa(texto: a.texto, correta: a.correta))
            .toList(),
        explicacao: p.explicacao,
        fonte: fontes.isEmpty ? 'Mock local' : fontes,
      );
    }).toList();
  }
}
