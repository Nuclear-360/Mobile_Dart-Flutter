import 'dart:io';
import 'dart:math';

import '../core/terminal/ansi.dart';
import '../core/terminal/terminal.dart';

/// Contador Geiger simulado mostrando a radiação natural de fundo.
///
/// É educativo: deixa claro, logo na tela inicial, que existe radiação
/// natural à nossa volta e que esse nível é normal e seguro.
abstract final class ContadorGeiger {
  static const List<String> _barras = ['▁', '▂', '▃', '▄', '▅', '▆'];
  static const int _pontos = 24;

  static Future<void> exibir({bool animar = true}) async {
    final random = Random();
    final historico = List<String>.generate(
      _pontos,
      (_) => animar ? ' ' : _barras[random.nextInt(3)],
      growable: true,
    );
    final ciclos = animar ? 32 : 1;

    for (var i = 0; i < ciclos; i++) {
      historico
        ..removeAt(0)
        ..add(_barras[random.nextInt(3)]);

      final leitura = 0.09 + random.nextDouble() * 0.06;
      final valor = leitura.toStringAsFixed(2).replaceAll('.', ',');

      final linha = '${Ansi.ambar}${Ansi.negrito}GEIGER${Ansi.reset}  '
          '${Ansi.verde}${historico.join()}${Ansi.reset}  '
          '${Ansi.negrito}$valor µSv/h${Ansi.reset}  '
          '${Ansi.textoSecundario}radiação natural · normal${Ansi.reset}';

      stdout.write('\r${Terminal.centralizar(linha)}');
      if (animar) await Terminal.pausa(70);
    }
    stdout.writeln();
  }
}
