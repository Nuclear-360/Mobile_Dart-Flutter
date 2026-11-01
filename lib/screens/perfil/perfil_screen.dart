import 'dart:io';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../models/enums.dart';
import '../../state/sessao.dart';
import '../../widgets/cabecalho.dart';

/// Perfil do agente: lê o estado da sessão (usuário, XP, patente, acertos)
/// e mostra as insígnias conquistadas conforme o progresso.
class PerfilScreen extends Tela {
  const PerfilScreen();

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    Cabecalho.exibir('Perfil');
    final s = Sessao.instancia;
    final u = s.usuario;

    if (u == null) {
      stdout.writeln(
          '  ${Ansi.textoSecundario}Nenhum agente logado.${Ansi.reset}');
      Terminal.ler('\n  ${Ansi.tenue}ENTER para voltar${Ansi.reset} ');
      nav.pop();
      return;
    }

    void linha(String rotulo, String valor) => stdout.writeln(
          '  ${Ansi.textoSecundario}${rotulo.padRight(12)}${Ansi.reset}'
          '${Ansi.texto}$valor${Ansi.reset}',
        );

    linha('Apelido', u.apelido);
    linha('E-mail', u.email);
    linha(
        'Perfil', u.perfil == PerfilUsuario.professor ? 'Professor' : 'Aluno');
    linha('Faixa', u.faixaEtaria);
    stdout.writeln();
    stdout.writeln('  ${Ansi.ambar}${Ansi.negrito}${s.patente}${Ansi.reset}');
    linha('XP', '${s.xp}');
    linha('Acertos', '${s.acertos}');
    stdout.writeln();

    stdout.writeln('  ${Ansi.negrito}Insígnias${Ansi.reset}');
    final insignias = _insignias(s.xp, s.acertos);
    if (insignias.isEmpty) {
      stdout.writeln(
          '  ${Ansi.textoSecundario}Jogue as missões para conquistar insígnias.${Ansi.reset}');
    } else {
      for (final i in insignias) {
        stdout.writeln(
            '  ${Ansi.verde}★${Ansi.reset} ${Ansi.texto}$i${Ansi.reset}');
      }
    }

    Terminal.ler('\n  ${Ansi.tenue}ENTER para voltar${Ansi.reset} ');
    nav.pop();
  }

  List<String> _insignias(int xp, int acertos) {
    final lista = <String>[];
    if (acertos >= 1) lista.add('Primeira verdade revelada');
    if (xp >= 20) lista.add('Desmistificador');
    if (xp >= 80) lista.add('Agente de Campo');
    if (xp >= 200) lista.add('Guardião da Ciência');
    return lista;
  }
}
