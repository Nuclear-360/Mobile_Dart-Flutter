import 'dart:io';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../widgets/cabecalho.dart';

/// Dados que a tela de Resultado recebe por parâmetro.
class ResultadoView {
  const ResultadoView({
    required this.acertou,
    required this.explicacao,
    required this.fonte,
    required this.xpGanho,
  });

  final bool acertou;
  final String explicacao;
  final String fonte;
  final int xpGanho;
}

/// Mostra o retorno de uma resposta: acerto/erro, explicação objetiva e a
/// referência — exatamente o que o desafio pede após cada resposta.
/// Recebe um [ResultadoView] como parâmetro.
class ResultadoScreen extends Tela {
  const ResultadoScreen();

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    final r = argumentos as ResultadoView?;
    if (r == null) {
      nav.pop();
      return;
    }

    Cabecalho.exibir('Resultado');

    if (r.acertou) {
      stdout.writeln('  ${Ansi.negrito}${Ansi.verde}✔ RESPOSTA CORRETA'
          '${Ansi.reset}   ${Ansi.ambar}+${r.xpGanho} XP${Ansi.reset}');
    } else {
      stdout.writeln(
          '  ${Ansi.negrito}${Ansi.alerta}✘ NÃO FOI DESSA VEZ${Ansi.reset}');
    }
    stdout.writeln();

    stdout.writeln('  ${Ansi.ciano}Por quê:${Ansi.reset}');
    for (final l in Terminal.quebrar(r.explicacao, 60)) {
      stdout.writeln('  ${Ansi.texto}$l${Ansi.reset}');
    }
    stdout.writeln();
    stdout.writeln(
        '  ${Ansi.ciano}Fonte:${Ansi.reset} ${Ansi.textoSecundario}${r.fonte}${Ansi.reset}');

    Terminal.ler('\n  ${Ansi.tenue}ENTER para continuar${Ansi.reset} ');
    nav.pop();
  }
}
