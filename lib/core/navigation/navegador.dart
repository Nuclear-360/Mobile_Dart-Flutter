import 'tela.dart';

typedef ConstrutorTela = Tela Function();

class _EntradaPilha {
  const _EntradaPilha(this.nome, this.tela, this.argumentos);

  final String nome;
  final Tela tela;
  final Object? argumentos;
}

/// Pilha de navegação inspirada no `Navigator` do Flutter:
/// `push`, `pop` e `pushReplacement`, com passagem de argumentos.
class Navegador {
  Navegador(this._rotas);

  final Map<String, ConstrutorTela> _rotas;
  final List<_EntradaPilha> _pilha = [];

  bool get podeVoltar => _pilha.length > 1;

  String? get rotaAtual => _pilha.isEmpty ? null : _pilha.last.nome;

  /// Abre a rota inicial e mantém o app rodando enquanto houver telas.
  Future<void> iniciar(String rotaInicial, {Object? argumentos}) async {
    push(rotaInicial, argumentos: argumentos);
    while (_pilha.isNotEmpty) {
      final atual = _pilha.last;
      await atual.tela.exibir(this, atual.argumentos);
    }
  }

  void push(String nome, {Object? argumentos}) {
    final construtor = _rotas[nome];
    if (construtor == null) {
      throw ArgumentError('Rota não registrada: $nome');
    }
    _pilha.add(_EntradaPilha(nome, construtor(), argumentos));
  }

  void pop() {
    if (_pilha.isNotEmpty) _pilha.removeLast();
  }

  void pushReplacement(String nome, {Object? argumentos}) {
    pop();
    push(nome, argumentos: argumentos);
  }

  /// Esvazia a pilha e encerra o app.
  void sair() => _pilha.clear();
}
