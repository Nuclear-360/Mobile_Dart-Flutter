import 'dart:io';
import 'dart:math';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../data/mock_data.dart';
import '../../widgets/cabecalho.dart';

class SobreScreen extends Tela {
  const SobreScreen();

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    Cabecalho.exibir('Sobre');
    final largura = min(Terminal.largura - 4, 64);

    void paragrafo(String texto) {
      for (final linha in Terminal.quebrar(texto, largura)) {
        stdout.writeln('  ${Ansi.texto}$linha${Ansi.reset}');
      }
      stdout.writeln();
    }

    void titulo(String texto) =>
        stdout.writeln('  ${Ansi.negrito}${Ansi.ciano}$texto${Ansi.reset}');

    paragrafo(
      'O Nuclear 360 é uma plataforma gamificada que mostra, de forma simples '
      'e sempre com fontes oficiais, como a tecnologia nuclear está presente '
      'na saúde, na agricultura, na indústria, na pesquisa e na energia.',
    );

    titulo('Parceiro');
    paragrafo(
      'AMAZUL — Amazônia Azul Tecnologias de Defesa, ligada à Marinha do '
      'Brasil e ao Programa Nuclear da Marinha. Challenge FIAP.',
    );

    titulo('Distritos da cidade');
    for (final d in MockData.distritos) {
      stdout.writeln(
        '  ${Ansi.verde}•${Ansi.reset} ${d.nome.padRight(15)}'
        '${Ansi.textoSecundario}${d.area.rotulo}${Ansi.reset}',
      );
    }
    stdout.writeln();

    titulo('Equipe');
    stdout.writeln('  Pedro    ${Ansi.textoSecundario}Mobile e Cloud${Ansi.reset}');
    stdout.writeln('  Matheus  ${Ansi.textoSecundario}Java e Banco de Dados${Ansi.reset}');
    stdout.writeln('  Lucas    ${Ansi.textoSecundario}QA, IoT e .NET${Ansi.reset}');
    stdout.writeln();

    Terminal.ler('  ${Ansi.tenue}ENTER para voltar${Ansi.reset} ');
    nav.pop();
  }
}
