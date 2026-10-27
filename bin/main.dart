import 'package:nuclear_360/core/terminal/ansi.dart';
import 'package:nuclear_360/core/terminal/terminal.dart';

Future<void> main() async {
  Terminal.limpar();
  await Terminal.digitar('Nuclear 360', cor: Ansi.verde);
  await Terminal.barraProgresso('Carregando', cor: Ansi.ciano);
}
