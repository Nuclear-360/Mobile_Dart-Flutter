import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'ansi.dart';

/// Utilitários de terminal: limpar tela, animações, centralização e leitura.
///
/// É a única camada (junto com `screens/` e `widgets/`) que conhece o
/// terminal. Na migração para Flutter, ela é substituída pelos widgets.
abstract final class Terminal {
  static final RegExp _regexAnsi = RegExp(r'\x1B\[[0-9;?]*[A-Za-z]');
  static final Random _random = Random();
  static const List<String> _ruidos = ['░', '▒', '▓', '█', '#', '%', '@', '*'];

  /// Largura do terminal em colunas (80 quando não for possível detectar).
  static int get largura {
    if (stdout.hasTerminal) {
      try {
        return stdout.terminalColumns;
      } catch (_) {
        return 80;
      }
    }
    return 80;
  }

  /// Tamanho do texto como aparece na tela, ignorando os códigos de cor.
  static int larguraVisivel(String texto) =>
      texto.replaceAll(_regexAnsi, '').runes.length;

  static Future<void> pausa(int ms) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  static void limpar() {
    if (Ansi.suportado) {
      stdout.write('\x1B[2J\x1B[3J\x1B[H');
    } else {
      stdout.write('\n' * 3);
    }
  }

  static void esconderCursor() {
    if (Ansi.suportado) stdout.write('\x1B[?25l');
  }

  static void mostrarCursor() {
    if (Ansi.suportado) stdout.write('\x1B[?25h');
  }

  /// Devolve o terminal ao estado normal (cursor visível e sem cor).
  static void restaurar() {
    mostrarCursor();
    stdout.write(Ansi.reset);
  }

  static void subirLinhas(int quantidade) {
    if (Ansi.suportado && quantidade > 0) {
      stdout.write('\x1B[${quantidade}A');
    }
  }

  static void limparLinha() {
    if (Ansi.suportado) {
      stdout.write('\x1B[2K\r');
    } else {
      stdout.write('\r${' ' * (largura - 1)}\r');
    }
  }

  /// Caractere aleatório usado nos efeitos de sinal e decodificação.
  static String ruido() => _ruidos[_random.nextInt(_ruidos.length)];

  /// Espaços à esquerda para centralizar um bloco de [larguraBloco] colunas.
  static String margem(int larguraBloco) =>
      ' ' * max(2, (largura - larguraBloco) ~/ 2);

  static String centralizar(String texto) {
    final espaco = (largura - larguraVisivel(texto)) ~/ 2;
    return espaco > 0 ? '${' ' * espaco}$texto' : texto;
  }

  static void escrever(String texto, {bool centro = false}) {
    stdout.writeln(centro ? centralizar(texto) : texto);
  }

  /// Efeito máquina de escrever.
  static Future<void> digitar(
    String texto, {
    String cor = '',
    int msPorLetra = 28,
  }) async {
    stdout.write(cor);
    for (final letra in texto.runes) {
      stdout.write(String.fromCharCode(letra));
      await pausa(msPorLetra);
    }
    stdout.writeln(Ansi.reset);
  }

  /// Barra animada que enche até [ate] (de 0.0 a 1.0).
  static Future<void> barraProgresso(
    String rotulo, {
    double ate = 1.0,
    int tamanho = 30,
    int duracaoMs = 1200,
    String cor = '',
  }) async {
    final alvo = min(max((tamanho * ate).round(), 0), tamanho);
    final passos = max(alvo, 1);
    for (var i = 0; i <= alvo; i++) {
      final cheio = '█' * i;
      final vazio = '░' * (tamanho - i);
      final pct = (i * 100 ~/ tamanho).toString().padLeft(3);
      stdout.write(
        '\r  $rotulo  $cor$cheio${Ansi.tenue}$vazio${Ansi.reset} $pct%',
      );
      await pausa(duracaoMs ~/ passos);
    }
    final pctFinal = (ate * 100).round().toString().padLeft(3);
    stdout.writeln(
      '\r  $rotulo  $cor${'█' * alvo}${Ansi.tenue}${'░' * (tamanho - alvo)}'
      '${Ansi.reset} $pctFinal%',
    );
  }

  /// Quebra um texto em linhas de no máximo [larguraMaxima] caracteres.
  static List<String> quebrar(String texto, int larguraMaxima) {
    final linhas = <String>[];
    var atual = StringBuffer();
    for (final palavra in texto.split(' ')) {
      if (atual.isEmpty) {
        atual.write(palavra);
      } else if (atual.length + 1 + palavra.length <= larguraMaxima) {
        atual.write(' $palavra');
      } else {
        linhas.add(atual.toString());
        atual = StringBuffer(palavra);
      }
    }
    if (atual.isNotEmpty) linhas.add(atual.toString());
    return linhas;
  }

  /// Lê uma linha digitada pelo usuário (com o cursor visível).
  static String ler(String prompt) {
    mostrarCursor();
    stdout.write(prompt);
    final entrada = stdin.readLineSync(encoding: utf8) ?? '';
    return entrada.trim();
  }
}
