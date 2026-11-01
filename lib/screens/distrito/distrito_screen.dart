import 'dart:io';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/rotas.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../models/distrito.dart';
import '../../models/enums.dart';
import '../../widgets/cabecalho.dart';

/// Detalhe de um distrito. Recebe o [Distrito] escolhido no Mapa como
/// parâmetro (demonstra a passagem de parâmetros entre telas) e lista as
/// missões, levando cada tipo à sua tela.
class DistritoScreen extends Tela {
  DistritoScreen();

  String? _aviso;

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    final distrito = argumentos as Distrito?;
    if (distrito == null) {
      nav.pop();
      return;
    }

    Cabecalho.exibir('Distrito: ${distrito.nome}');
    final largura = 62;

    stdout.writeln('  ${Ansi.alerta}● Sem tecnologia nuclear:${Ansi.reset}');
    for (final l in Terminal.quebrar(distrito.semNuclear, largura)) {
      stdout.writeln('    ${Ansi.textoSecundario}$l${Ansi.reset}');
    }
    stdout.writeln(
        '  ${Ansi.verde}● Reacendendo, a cidade recupera:${Ansi.reset}');
    for (final l in Terminal.quebrar(distrito.comNuclear, largura)) {
      stdout.writeln('    ${Ansi.texto}$l${Ansi.reset}');
    }
    stdout.writeln();

    stdout.writeln('  ${Ansi.negrito}Missões${Ansi.reset}');
    for (var i = 0; i < distrito.missoes.length; i++) {
      final m = distrito.missoes[i];
      stdout.writeln(
        '  ${Ansi.verde}${Ansi.negrito}${i + 1}${Ansi.reset}  '
        '${Ansi.texto}${m.titulo}${Ansi.reset} '
        '${Ansi.textoSecundario}(${m.tipo.rotulo})${Ansi.reset}',
      );
      stdout.writeln('     ${Ansi.textoSecundario}${m.descricao}${Ansi.reset}');
    }

    stdout.writeln();
    stdout.writeln('  ${Ansi.ciano}V${Ansi.reset}) Voltar ao Mapa');
    stdout.writeln();
    if (_aviso != null) {
      stdout.writeln('  ${Ansi.alerta}$_aviso${Ansi.reset}');
    }

    final opcao = Terminal.ler('  ${Ansi.verde}>${Ansi.reset} ').toLowerCase();
    _aviso = null;

    if (opcao == 'v') {
      nav.pop();
      return;
    }

    final n = int.tryParse(opcao);
    if (n == null || n < 1 || n > distrito.missoes.length) {
      _aviso = 'Opção inválida.';
      return;
    }

    final missao = distrito.missoes[n - 1];
    switch (missao.tipo) {
      case TipoMissao.quiz:
        nav.push(Rotas.quiz);
      case TipoMissao.swipe:
        nav.push(Rotas.verdadeOuRadioativo);
      case TipoMissao.simulador:
      case TipoMissao.narrativa:
        _mostrarEmBreve(missao.titulo);
        _aviso = 'A missão "${missao.titulo}" chega na próxima sprint.';
    }
  }

  void _mostrarEmBreve(String titulo) {
    stdout.writeln();
    stdout.writeln('  ${Ansi.ambar}▶ $titulo — em breve.${Ansi.reset}');
  }
}
