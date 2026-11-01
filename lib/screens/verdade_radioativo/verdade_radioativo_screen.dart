import 'dart:io';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/rotas.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../data/mock_data.dart';
import '../../models/cartao_mito.dart';
import '../../state/sessao.dart';
import '../../widgets/cabecalho.dart';
import '../resultado/resultado_screen.dart';

/// Verdade ou Radioativo: o usuário classifica cada afirmação como verdade
/// ou mito. Mantém o placar em estado (atualiza a cada carta) e usa dados
/// mockados — não há endpoint para os cartões na API desta sprint.
class VerdadeRadioativoScreen extends Tela {
  VerdadeRadioativoScreen();

  final List<CartaoMito> _cartoes =
      MockData.cartoes.where((c) => c.publicavel).toList();
  int _indice = 0;
  int _acertos = 0;
  String? _aviso;

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    if (_indice >= _cartoes.length) {
      Cabecalho.exibir('Verdade ou Radioativo — fim');
      stdout.writeln(
        '  ${Ansi.negrito}Você acertou ${Ansi.verde}$_acertos'
        '${Ansi.reset}${Ansi.negrito} de ${_cartoes.length} cartas.${Ansi.reset}',
      );
      stdout.writeln(
          '  ${Ansi.ambar}XP total: ${Sessao.instancia.xp}${Ansi.reset}');
      Terminal.ler('\n  ${Ansi.tenue}ENTER para voltar${Ansi.reset} ');
      nav.pop();
      return;
    }

    final carta = _cartoes[_indice];
    Cabecalho.exibir(
        'Verdade ou Radioativo  (${_indice + 1}/${_cartoes.length})');
    stdout.writeln('  ${Ansi.ambar}XP: ${Sessao.instancia.xp}${Ansi.reset}\n');

    for (final l in Terminal.quebrar(carta.afirmacao, 62)) {
      stdout.writeln('  ${Ansi.negrito}${Ansi.texto}$l${Ansi.reset}');
    }
    stdout.writeln();
    stdout.writeln('  ${Ansi.verde}V${Ansi.reset}) Verdade     '
        '${Ansi.alerta}R${Ansi.reset}) Radioativo (mito)');
    stdout.writeln();
    if (_aviso != null) {
      stdout.writeln('  ${Ansi.alerta}$_aviso${Ansi.reset}');
    }

    final r = Terminal.ler('  ${Ansi.verde}>${Ansi.reset} ').toLowerCase();
    if (r != 'v' && r != 'r') {
      _aviso = 'Responda com V (verdade) ou R (radioativo).';
      return;
    }
    _aviso = null;

    final disseVerdade = r == 'v';
    final acertou = carta.ehVerdade == disseVerdade;
    const xp = 5;
    if (acertou) {
      _acertos++;
      Sessao.instancia.ganharXp(xp);
    }
    _indice++;

    final fontes = carta.referencias.map((e) => e.instituicao).join(', ');
    nav.push(
      Rotas.resultado,
      argumentos: ResultadoView(
        acertou: acertou,
        explicacao: carta.explicacao,
        fonte: fontes.isEmpty ? 'Mock local' : fontes,
        xpGanho: acertou ? xp : 0,
      ),
    );
  }
}
