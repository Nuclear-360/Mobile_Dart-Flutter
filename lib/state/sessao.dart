import '../models/usuario.dart';

/// Estado global da sessão, compartilhado entre as telas.
///
/// Guarda o usuário logado e o XP acumulado durante o uso. As telas leem
/// e alteram esse estado (ganhar XP no quiz, por exemplo) e a interface é
/// redesenhada com o valor novo — o equivalente, em Dart puro, ao que o
/// `setState`/estado faz no Flutter.
class Sessao {
  Sessao._();

  static final Sessao instancia = Sessao._();

  Usuario? _usuario;
  int _xp = 0;
  int _acertos = 0;

  Usuario? get usuario => _usuario;
  int get xp => _xp;
  int get acertos => _acertos;
  bool get logado => _usuario != null;

  void entrar(Usuario usuario) {
    _usuario = usuario;
  }

  void sair() {
    _usuario = null;
    _xp = 0;
    _acertos = 0;
  }

  void ganharXp(int valor) {
    _xp += valor;
    if (valor > 0) _acertos++;
    _usuario = _usuario?.copyWith(xp: _xp);
  }

  /// Patente do agente conforme o XP, usada no Perfil.
  String get patente {
    if (_xp >= 200) return 'Agente Sênior';
    if (_xp >= 80) return 'Agente de Campo';
    if (_xp >= 20) return 'Recruta';
    return 'Novato';
  }
}
