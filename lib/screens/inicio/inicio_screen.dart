import 'dart:io';
import 'dart:math';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/rotas.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../data/mock_data.dart';
import '../../models/cartao_mito.dart';
import '../../widgets/cartao_fato.dart';
import '../../widgets/contador_geiger.dart';
import '../../widgets/logo_nuclear.dart';

/// Tela inicial: logo decodificado, contador Geiger, fato do dia e menu.
///
/// Guarda estado entre redesenhos (como um StatefulWidget): o logo só
/// anima na primeira vez e o fato do dia continua o mesmo.
class InicioScreen extends Tela {
  InicioScreen();

  bool _primeiraVez = true;
  String? _aviso;
  late final CartaoMito _fatoDoDia = _sortearFato();

  static CartaoMito _sortearFato() {
    final verdades =
        MockData.cartoes.where((c) => c.ehVerdade && c.publicavel).toList();
    return verdades[Random().nextInt(verdades.length)];
  }

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    Terminal.limpar();
    Terminal.esconderCursor();
    stdout.writeln();

    await LogoNuclear.desenhar(animar: _primeiraVez);
    stdout.writeln();
    Terminal.escrever(
      '${Ansi.textoSecundario}— reacenda a cidade com a verdade —${Ansi.reset}',
      centro: true,
    );
    stdout.writeln();

    await ContadorGeiger.exibir(animar: _primeiraVez);
    stdout.writeln();

    CartaoFato.exibir(_fatoDoDia);
    stdout.writeln();

    _desenharMenu();
    _primeiraVez = false;

    final opcao = Terminal.ler('${Terminal.margem(62)}${Ansi.verde}>${Ansi.reset} ');
    _aviso = null;

    switch (opcao) {
      case '1':
        nav.push(Rotas.login);
      case '2':
        nav.push(Rotas.cadastro);
      case '3':
        nav.push(Rotas.sobre);
      case '0':
        await _encerrar();
        nav.sair();
      default:
        // Sem navegar: a tela é redesenhada com o aviso (como um setState).
        _aviso = 'Opção inválida. Digite 1, 2, 3 ou 0.';
    }
  }

  void _desenharMenu() {
    final margem = Terminal.margem(62);
    String item(String tecla, String texto) =>
        '$margem${Ansi.verde}${Ansi.negrito}[$tecla]${Ansi.reset}  '
        '${Ansi.texto}$texto${Ansi.reset}';

    stdout.writeln(item('1', 'Iniciar missão'));
    stdout.writeln(item('2', 'Criar conta de agente'));
    stdout.writeln(item('3', 'Sobre o Nuclear 360'));
    stdout.writeln(item('0', 'Sair'));
    stdout.writeln();

    if (_aviso != null) {
      stdout.writeln('$margem${Ansi.alerta}$_aviso${Ansi.reset}');
    }
  }

  Future<void> _encerrar() async {
    stdout.writeln();
    await Terminal.digitar(
      '${Terminal.margem(62)}Conexão encerrada. A cidade continua esperando por você.',
      cor: Ansi.textoSecundario,
      msPorLetra: 20,
    );
    stdout.writeln();
  }
}
