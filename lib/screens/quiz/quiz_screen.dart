import 'dart:io';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/rotas.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../data/pergunta_repository.dart';
import '../../models/quiz_item.dart';
import '../../state/sessao.dart';
import '../../widgets/cabecalho.dart';
import '../resultado/resultado_screen.dart';

/// Quiz das missões. Carrega as perguntas do backend Java (com fallback
/// para mock) e mantém o placar em estado, que é atualizado a cada resposta
/// e sobrevive à ida e volta para a tela de Resultado.
class QuizScreen extends Tela {
  QuizScreen({this.repositorio = const PerguntaRepository()});

  final PerguntaRepository repositorio;

  List<QuizItem> _itens = const [];
  OrigemQuiz _origem = OrigemQuiz.mock;
  bool _carregado = false;
  int _indice = 0;
  int _acertosNoQuiz = 0;
  String? _aviso;

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    if (!_carregado) {
      await _carregar();
    }

    // Fim do quiz: mostra o placar e volta para o distrito.
    if (_indice >= _itens.length) {
      _mostrarPlacar();
      Terminal.ler('\n  ${Ansi.tenue}ENTER para voltar${Ansi.reset} ');
      nav.pop();
      return;
    }

    _mostrarPergunta();

    final entrada = Terminal.ler('  ${Ansi.verde}Sua resposta>${Ansi.reset} ');
    final item = _itens[_indice];
    final escolha = int.tryParse(entrada);

    if (escolha == null || escolha < 1 || escolha > item.alternativas.length) {
      _aviso = 'Digite um número de 1 a ${item.alternativas.length}.';
      return; // redesenha a mesma pergunta
    }
    _aviso = null;

    final acertou = item.alternativas[escolha - 1].correta;
    const xp = 10;
    if (acertou) {
      _acertosNoQuiz++;
      Sessao.instancia.ganharXp(xp);
    }

    _indice++; // avança antes de ir ao resultado; na volta mostra a próxima

    nav.push(
      Rotas.resultado,
      argumentos: ResultadoView(
        acertou: acertou,
        explicacao: item.explicacao,
        fonte: item.fonte,
        xpGanho: acertou ? xp : 0,
      ),
    );
  }

  Future<void> _carregar() async {
    Cabecalho.exibir('Quiz Nuclear');
    stdout.write('  ${Ansi.textoSecundario}Carregando perguntas...${Ansi.reset}');
    final resultado = await repositorio.carregarQuiz();
    _itens = resultado.itens;
    _origem = resultado.origem;
    _carregado = true;
    Terminal.limparLinha();
  }

  void _mostrarPergunta() {
    final item = _itens[_indice];
    Cabecalho.exibir('Quiz Nuclear  (${_indice + 1}/${_itens.length})');

    final selo = _origem == OrigemQuiz.api
        ? '${Ansi.verde}● conectado à API Java${Ansi.reset}'
        : '${Ansi.ambar}● dados mock (API offline)${Ansi.reset}';
    stdout.writeln('  $selo    ${Ansi.ambar}XP: ${Sessao.instancia.xp}${Ansi.reset}\n');

    for (final l in Terminal.quebrar(item.enunciado, 62)) {
      stdout.writeln('  ${Ansi.negrito}${Ansi.texto}$l${Ansi.reset}');
    }
    stdout.writeln();
    for (var i = 0; i < item.alternativas.length; i++) {
      stdout.writeln(
        '  ${Ansi.verde}${i + 1}${Ansi.reset}) '
        '${Ansi.texto}${item.alternativas[i].texto}${Ansi.reset}',
      );
    }
    stdout.writeln();
    if (_aviso != null) {
      stdout.writeln('  ${Ansi.alerta}$_aviso${Ansi.reset}');
    }
  }

  void _mostrarPlacar() {
    Cabecalho.exibir('Quiz concluído');
    stdout.writeln(
      '  ${Ansi.negrito}Você acertou ${Ansi.verde}$_acertosNoQuiz'
      '${Ansi.reset}${Ansi.negrito} de ${_itens.length}.${Ansi.reset}',
    );
    stdout.writeln('  ${Ansi.ambar}XP total: ${Sessao.instancia.xp}${Ansi.reset}');
  }
}
