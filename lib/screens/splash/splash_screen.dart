import 'dart:io';
import 'dart:math';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/rotas.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../data/mock_data.dart';

/// Abertura narrativa: um sinal da resistência científica é interceptado
/// e mostra a cidade de 2070, apagada depois do banimento nuclear.
///
/// Recebe `true` como argumento para pular a introdução (`--sem-intro`).
class SplashScreen extends Tela {
  const SplashScreen();

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    final pularIntro = argumentos == true;

    if (!pularIntro) {
      Terminal.esconderCursor();
      await _sinalInterceptado();
      await _narrativa();
      await _relatorioDaCidade();
      Terminal.ler(
        '  ${Ansi.tenue}Pressione ENTER para assumir a missão...${Ansi.reset}',
      );
    }

    nav.pushReplacement(Rotas.inicio);
  }

  Future<void> _sinalInterceptado() async {
    Terminal.limpar();
    stdout.writeln('\n');

    final largura = min(Terminal.largura - 4, 60);
    for (var quadro = 0; quadro < 18; quadro++) {
      final ruido = List.generate(largura, (_) => Terminal.ruido()).join();
      stdout.write('\r  ${Ansi.alerta}${Ansi.tenue}$ruido${Ansi.reset}');
      await Terminal.pausa(55);
    }
    Terminal.limparLinha();

    await Terminal.digitar(
      '  ◉ SINAL INTERCEPTADO · CANAL DA RESISTÊNCIA CIENTÍFICA',
      cor: '${Ansi.negrito}${Ansi.ambar}',
      msPorLetra: 18,
    );
    await Terminal.pausa(600);
  }

  Future<void> _narrativa() async {
    stdout.writeln();
    await Terminal.digitar('  Brasil, 2070.', cor: Ansi.texto, msPorLetra: 60);
    await Terminal.pausa(500);
    await Terminal.digitar(
      '  Depois do Grande Pânico, a tecnologia nuclear foi banida do país.',
      cor: Ansi.texto,
    );
    await Terminal.digitar(
      '  Ninguém lembra mais dos fatos. Só lembram do medo.',
      cor: Ansi.textoSecundario,
    );
    await Terminal.pausa(700);
  }

  Future<void> _relatorioDaCidade() async {
    stdout.writeln();
    stdout.writeln(
      '  ${Ansi.negrito}${Ansi.ciano}RELATÓRIO DA CIDADE${Ansi.reset}',
    );
    stdout.writeln('  ${Ansi.textoSecundario}${'─' * 56}${Ansi.reset}');

    const giro = ['|', '/', '-', r'\'];
    for (final distrito in MockData.distritos) {
      final nome = distrito.nome.padRight(16, '.');
      for (var i = 0; i < 8; i++) {
        stdout.write(
          '\r  $nome ${Ansi.ambar}${giro[i % giro.length]} verificando'
          '${Ansi.reset}',
        );
        await Terminal.pausa(70);
      }
      Terminal.limparLinha();
      stdout.writeln(
        '  $nome ${Ansi.alerta}${Ansi.negrito}[ OFFLINE ]${Ansi.reset}',
      );
      stdout.writeln(
        '  ${' ' * 17}${Ansi.textoSecundario}${distrito.semNuclear}'
        '${Ansi.reset}',
      );
      await Terminal.pausa(250);
    }

    stdout.writeln();
    await Terminal.barraProgresso(
      'Confiança na ciência',
      ate: 0.03,
      cor: Ansi.alerta,
      duracaoMs: 600,
    );

    stdout.writeln();
    await Terminal.digitar(
      '  Sua missão: reacender a cidade com a verdade.',
      cor: '${Ansi.negrito}${Ansi.verde}',
      msPorLetra: 35,
    );
    stdout.writeln();
  }
}
