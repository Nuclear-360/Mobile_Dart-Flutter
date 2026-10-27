import 'dart:io';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../widgets/cabecalho.dart';

/// Tela provisória para as rotas que serão construídas nas próximas etapas.
class EmConstrucaoScreen extends Tela {
  const EmConstrucaoScreen({required this.titulo, required this.descricao});

  final String titulo;
  final String descricao;

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    Cabecalho.exibir(titulo);
    stdout.writeln('  ${Ansi.ambar}Esta tela chega na próxima etapa.${Ansi.reset}');
    stdout.writeln('  ${Ansi.textoSecundario}$descricao${Ansi.reset}');
    stdout.writeln();
    Terminal.ler('  ${Ansi.tenue}ENTER para voltar${Ansi.reset} ');
    nav.pop();
  }
}
