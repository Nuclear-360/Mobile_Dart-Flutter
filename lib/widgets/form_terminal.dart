import 'dart:io';

import '../core/terminal/ansi.dart';
import '../core/terminal/terminal.dart';

/// Validador de campo: devolve `null` se válido ou a mensagem de erro.
/// Mesmo contrato do `validator` do `TextFormField` no Flutter.
typedef Validador = String? Function(String valor);

/// Utilitários de formulário no terminal: leitura com validação em loop
/// (reexibindo o erro, como um campo de formulário faria) e seleção de opções.
abstract final class FormTerminal {
  /// Lê um campo e revalida até ficar válido, mostrando o erro em vermelho.
  static String lerValidado(String rotulo, Validador validador) {
    while (true) {
      final valor = Terminal.ler('  $rotulo: ');
      final erro = validador(valor);
      if (erro == null) return valor;
      stdout.writeln('  ${Ansi.alerta}✗ $erro${Ansi.reset}');
    }
  }

  /// Mostra opções numeradas e devolve a escolhida (equivale a um Dropdown).
  static String escolher(String rotulo, List<String> opcoes) {
    stdout.writeln('  ${Ansi.texto}$rotulo${Ansi.reset}');
    for (var i = 0; i < opcoes.length; i++) {
      stdout.writeln('    ${Ansi.verde}${i + 1}${Ansi.reset}) ${opcoes[i]}');
    }
    while (true) {
      final entrada = Terminal.ler('  Opção: ');
      final n = int.tryParse(entrada);
      if (n != null && n >= 1 && n <= opcoes.length) return opcoes[n - 1];
      stdout.writeln(
          '  ${Ansi.alerta}✗ Digite um número de 1 a ${opcoes.length}.${Ansi.reset}');
    }
  }

  /// Pergunta de sim/não (equivale a um Checkbox/Switch).
  static bool confirmar(String rotulo) {
    while (true) {
      final r = Terminal.ler('  $rotulo (s/n): ').toLowerCase();
      if (r == 's' || r == 'sim') return true;
      if (r == 'n' || r == 'nao' || r == 'não') return false;
      stdout.writeln('  ${Ansi.alerta}✗ Responda com s ou n.${Ansi.reset}');
    }
  }

  /// Caixa de destaque estilo Dialog/SnackBar com uma mensagem.
  static void aviso(String mensagem, {String cor = ''}) {
    final c = cor.isEmpty ? Ansi.verde : cor;
    stdout.writeln('  $c${'─' * 48}${Ansi.reset}');
    for (final linha in Terminal.quebrar(mensagem, 46)) {
      stdout.writeln('  $c│${Ansi.reset} $linha');
    }
    stdout.writeln('  $c${'─' * 48}${Ansi.reset}');
  }
}
