import 'dart:io';

import '../../core/navigation/navegador.dart';
import '../../core/navigation/tela.dart';
import '../../core/terminal/ansi.dart';
import '../../core/terminal/terminal.dart';
import '../../data/mock_data.dart';
import '../../models/item_dose.dart';
import '../../services/dose_service.dart';
import '../../widgets/cabecalho.dart';

/// Medidor de Bananas: o usuário monta o "seu dia" de radiação adicionando
/// e removendo itens, e o total em bananas é recalculado e atualizado na
/// tela a cada ação — um exemplo claro de estado que muda com a interação.
class MedidorScreen extends Tela {
  MedidorScreen();

  static const _dose = DoseService();
  final List<ItemDose> _itens = MockData.itensDose;
  final Map<int, int> _quantidades = {};
  String? _aviso;

  @override
  Future<void> exibir(Navegador nav, Object? argumentos) async {
    Cabecalho.exibir('Medidor de Bananas');
    stdout.writeln(
        '  ${Ansi.textoSecundario}Monte o seu dia e veja a dose em bananas.${Ansi.reset}\n');

    for (var i = 0; i < _itens.length; i++) {
      final item = _itens[i];
      final qtd = _quantidades[i] ?? 0;
      stdout.writeln(
        '  ${Ansi.verde}${i + 1}${Ansi.reset}  '
        '${Ansi.texto}${item.nome.padRight(26)}${Ansi.reset}'
        '${Ansi.textoSecundario}${item.doseMicroSievert} µSv${Ansi.reset}'
        '   ${Ansi.ambar}x$qtd${Ansi.reset}',
      );
    }

    // Estado recalculado a cada ação:
    final totalMicroSv = _total();
    final bananas = _dose.emBananas(totalMicroSv);
    stdout.writeln();
    stdout.writeln(
      '  ${Ansi.negrito}Total: ${Ansi.ciano}${bananas.toStringAsFixed(1)} bananas'
      '${Ansi.reset}${Ansi.negrito}  (${totalMicroSv.toStringAsFixed(2)} µSv)${Ansi.reset}',
    );
    stdout.writeln(
        '  ${Ansi.textoSecundario}Ex.: digite 2 para somar o item 2; -2 para tirar.${Ansi.reset}');
    stdout.writeln(
        '  ${Ansi.ciano}L${Ansi.reset}) Limpar   ${Ansi.ciano}V${Ansi.reset}) Voltar');
    stdout.writeln();
    if (_aviso != null) {
      stdout.writeln('  ${Ansi.alerta}$_aviso${Ansi.reset}');
    }

    final entrada =
        Terminal.ler('  ${Ansi.verde}>${Ansi.reset} ').toLowerCase();
    _aviso = null;

    if (entrada == 'v') {
      nav.pop();
      return;
    }
    if (entrada == 'l') {
      _quantidades.clear();
      return;
    }

    final n = int.tryParse(entrada);
    if (n == null || n == 0 || n.abs() > _itens.length) {
      _aviso = 'Digite o número de um item (ou negativo para remover).';
      return;
    }
    final idx = n.abs() - 1;
    final atual = _quantidades[idx] ?? 0;
    final novo = n > 0 ? atual + 1 : atual - 1;
    _quantidades[idx] = novo < 0 ? 0 : novo;
  }

  double _total() {
    var soma = 0.0;
    _quantidades.forEach((idx, qtd) {
      soma += _itens[idx].doseMicroSievert * qtd;
    });
    return soma;
  }
}
