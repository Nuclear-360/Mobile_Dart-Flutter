import 'dart:io';
import 'dart:math';

import '../core/terminal/ansi.dart';
import '../core/terminal/terminal.dart';

class _LinhaLogo {
  const _LinhaLogo(this.texto, this.cor);

  final String texto;
  final String cor;
}

/// Logo "NUCLEAR 360" em arte ASCII, com efeito de decodificação de sinal.
abstract final class LogoNuclear {
  static const int larguraMinima = 64;

  static const Map<String, List<String>> _glifos = {
    'N': [
      '███╗   ██╗',
      '████╗  ██║',
      '██╔██╗ ██║',
      '██║╚██╗██║',
      '██║ ╚████║',
      '╚═╝  ╚═══╝',
    ],
    'U': [
      '██╗   ██╗',
      '██║   ██║',
      '██║   ██║',
      '██║   ██║',
      '╚██████╔╝',
      ' ╚═════╝ ',
    ],
    'C': [
      ' ██████╗',
      '██╔════╝',
      '██║     ',
      '██║     ',
      '╚██████╗',
      ' ╚═════╝',
    ],
    'L': [
      '██╗     ',
      '██║     ',
      '██║     ',
      '██║     ',
      '███████╗',
      '╚══════╝',
    ],
    'E': [
      '███████╗',
      '██╔════╝',
      '█████╗  ',
      '██╔══╝  ',
      '███████╗',
      '╚══════╝',
    ],
    'A': [
      ' █████╗ ',
      '██╔══██╗',
      '███████║',
      '██╔══██║',
      '██║  ██║',
      '╚═╝  ╚═╝',
    ],
    'R': [
      '██████╗ ',
      '██╔══██╗',
      '██████╔╝',
      '██╔══██╗',
      '██║  ██║',
      '╚═╝  ╚═╝',
    ],
    '3': [
      '██████╗ ',
      '╚════██╗',
      ' █████╔╝',
      ' ╚═══██╗',
      '██████╔╝',
      '╚═════╝ ',
    ],
    '6': [
      ' ██████╗ ',
      '██╔════╝ ',
      '███████╗ ',
      '██╔═══██╗',
      '╚██████╔╝',
      ' ╚═════╝ ',
    ],
    '0': [
      ' ██████╗ ',
      '██╔═████╗',
      '██║██╔██║',
      '████╔╝██║',
      '╚██████╔╝',
      ' ╚═════╝ ',
    ],
  };

  /// Junta os glifos de uma palavra em 6 linhas de mesma largura.
  static List<String> _montar(String palavra) {
    final glifos = palavra.split('').map((letra) => _glifos[letra]!).toList();
    return List.generate(6, (linha) {
      return glifos.map((glifo) {
        final largura = glifo.map((r) => r.length).reduce(max);
        return glifo[linha].padRight(largura);
      }).join();
    });
  }

  static String _embaralhar(String texto, double progresso, Random random) {
    final buffer = StringBuffer();
    for (final rune in texto.runes) {
      final letra = String.fromCharCode(rune);
      if (letra == ' ' || random.nextDouble() < progresso) {
        buffer.write(letra);
      } else {
        buffer.write(Terminal.ruido());
      }
    }
    return buffer.toString();
  }

  /// Desenha o logo. Com [animar], o logo surge como um sinal sendo
  /// decodificado: ruído que vai se transformando nas letras.
  static Future<void> desenhar({bool animar = true}) async {
    if (Terminal.largura < larguraMinima) {
      _desenharCompacto();
      return;
    }

    final linhas = [
      for (final l in _montar('NUCLEAR')) _LinhaLogo(l, Ansi.verde),
      const _LinhaLogo('', ''),
      for (final l in _montar('360')) _LinhaLogo(l, Ansi.ciano),
    ];

    final quadros = animar && Ansi.suportado ? 18 : 1;
    final random = Random();

    for (var quadro = 1; quadro <= quadros; quadro++) {
      final progresso = quadro / quadros;
      for (final linha in linhas) {
        final texto = quadro == quadros
            ? linha.texto
            : _embaralhar(linha.texto, progresso, random);
        final cor = quadro == quadros ? '${Ansi.negrito}${linha.cor}' : linha.cor;
        stdout.writeln(Terminal.centralizar('$cor$texto${Ansi.reset}'));
      }
      if (quadro < quadros) {
        await Terminal.pausa(55);
        Terminal.subirLinhas(linhas.length);
      }
    }
  }

  static void _desenharCompacto() {
    final verde = '${Ansi.negrito}${Ansi.verde}';
    final ciano = '${Ansi.negrito}${Ansi.ciano}';
    Terminal.escrever('╔═══════════════════════╗', centro: true);
    Terminal.escrever(
      '║  ${verde}N U C L E A R$ciano  360${Ansi.reset}  ║',
      centro: true,
    );
    Terminal.escrever('╚═══════════════════════╝', centro: true);
  }
}
