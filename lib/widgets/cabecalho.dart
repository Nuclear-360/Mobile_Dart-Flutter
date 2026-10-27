import 'dart:io';
import 'dart:math';

import '../core/terminal/ansi.dart';
import '../core/terminal/terminal.dart';

/// Cabeçalho padrão das telas internas (equivale à AppBar no Flutter).
abstract final class Cabecalho {
  static void exibir(String titulo) {
    Terminal.limpar();
    stdout.writeln();
    stdout.writeln(
      '  ${Ansi.negrito}${Ansi.verde}NUCLEAR ${Ansi.ciano}360${Ansi.reset}'
      '  ${Ansi.textoSecundario}›${Ansi.reset}  ${Ansi.negrito}$titulo${Ansi.reset}',
    );
    final largura = min(Terminal.largura - 4, 64);
    stdout.writeln('  ${Ansi.textoSecundario}${'─' * largura}${Ansi.reset}');
    stdout.writeln();
  }
}
