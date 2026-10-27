import 'dart:io';
import 'dart:math';

import '../core/terminal/ansi.dart';
import '../core/terminal/terminal.dart';
import '../models/cartao_mito.dart';

/// Bloco "Você sabia?" com um fato, sua explicação e a fonte.
abstract final class CartaoFato {
  static void exibir(CartaoMito cartao, {int largura = 62}) {
    final w = min(largura, Terminal.largura - 4);
    final margem = Terminal.margem(w);

    stdout.writeln('$margem${Ansi.ambar}${Ansi.negrito}◆ VOCÊ SABIA?${Ansi.reset}');
    for (final linha in Terminal.quebrar(cartao.afirmacao, w)) {
      stdout.writeln('$margem${Ansi.texto}$linha${Ansi.reset}');
    }
    for (final linha in Terminal.quebrar(cartao.explicacao, w)) {
      stdout.writeln('$margem${Ansi.textoSecundario}$linha${Ansi.reset}');
    }
    final fontes = cartao.referencias.map((r) => r.instituicao).join(', ');
    stdout.writeln('$margem${Ansi.ciano}Fonte: $fontes${Ansi.reset}');
  }
}
