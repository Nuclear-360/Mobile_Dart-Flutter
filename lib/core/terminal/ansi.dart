import 'dart:io';

import '../theme/paleta.dart';

/// Converte a [Paleta] em sequências de cor ANSI (24 bits) para o terminal.
///
/// Se o terminal não suportar cores, todos os códigos viram texto vazio
/// e o app continua funcionando sem cor.
abstract final class Ansi {
  static final bool suportado = stdout.supportsAnsiEscapes;

  static String _rgb(int argb) {
    if (!suportado) return '';
    final r = (argb >> 16) & 0xFF;
    final g = (argb >> 8) & 0xFF;
    final b = argb & 0xFF;
    return '\x1B[38;2;$r;$g;${b}m';
  }

  static String get reset => suportado ? '\x1B[0m' : '';
  static String get negrito => suportado ? '\x1B[1m' : '';
  static String get tenue => suportado ? '\x1B[2m' : '';

  static String get verde => _rgb(Paleta.verdeNeon);
  static String get ciano => _rgb(Paleta.ciano);
  static String get alerta => _rgb(Paleta.alerta);
  static String get ambar => _rgb(Paleta.ambar);
  static String get texto => _rgb(Paleta.texto);
  static String get textoSecundario => _rgb(Paleta.textoSecundario);
}
