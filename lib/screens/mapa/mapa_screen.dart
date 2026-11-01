import 'dart:io';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/rotas.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../data/mock_data.dart';
import '../../state/sessao.dart';
import '../../widgets/cabecalho.dart';

/// Mapa da Cidade: tela principal depois do login. Lista os distritos
/// (as áreas de aplicação da tecnologia nuclear) e leva ao detalhe de cada um,
/// passando o distrito escolhido como parâmetro para a próxima tela.
class MapaScreen extends Tela {
  MapaScreen();

  String? _aviso;

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    final distritos = MockData.distritos;
    Cabecalho.exibir('Mapa da Cidade');

    final apelido = Sessao.instancia.usuario?.apelido ?? 'agente';
    stdout.writeln(
      '  ${Ansi.texto}Agente $apelido${Ansi.reset}   '
      '${Ansi.ambar}XP: ${Sessao.instancia.xp}${Ansi.reset}',
    );
    stdout.writeln(
        '  ${Ansi.textoSecundario}Escolha um distrito para reacender.${Ansi.reset}\n');

    for (var i = 0; i < distritos.length; i++) {
      final d = distritos[i];
      stdout.writeln(
        '  ${Ansi.verde}${Ansi.negrito}${i + 1}${Ansi.reset}  '
        '${Ansi.texto}${d.nome.padRight(16)}${Ansi.reset}'
        '${Ansi.textoSecundario}${d.area.rotulo}${Ansi.reset}',
      );
    }

    stdout.writeln();
    stdout.writeln('  ${Ansi.ciano}B${Ansi.reset}) Medidor de Bananas   '
        '${Ansi.ciano}P${Ansi.reset}) Perfil   '
        '${Ansi.ciano}S${Ansi.reset}) Sair');
    stdout.writeln();
    if (_aviso != null) {
      stdout.writeln('  ${Ansi.alerta}$_aviso${Ansi.reset}');
    }

    final opcao = Terminal.ler('  ${Ansi.verde}>${Ansi.reset} ').toLowerCase();
    _aviso = null;

    switch (opcao) {
      case 'b':
        nav.push(Rotas.medidorBananas);
      case 'p':
        nav.push(Rotas.perfil);
      case 's':
        Sessao.instancia.sair();
        nav.pushReplacement(Rotas.inicio);
      default:
        final n = int.tryParse(opcao);
        if (n != null && n >= 1 && n <= distritos.length) {
          // passa o distrito escolhido como parâmetro para a tela de detalhe
          nav.push(Rotas.distrito, argumentos: distritos[n - 1]);
        } else {
          _aviso = 'Opção inválida.';
        }
    }
  }
}
