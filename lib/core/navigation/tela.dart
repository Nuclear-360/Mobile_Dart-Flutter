import 'navegador.dart';

/// Contrato de uma tela do app (equivale a uma tela/Widget no Flutter).
///
/// Ao terminar [exibir], a tela deve navegar (push, pop, pushReplacement
/// ou sair). Se não navegar, o [Navegador] exibe a mesma tela de novo,
/// como um `setState` redesenhando a interface.
abstract class Tela {
  const Tela();

  Future<void> exibir(Navegador nav, Object? argumentos);
}
