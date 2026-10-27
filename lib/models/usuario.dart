import 'enums.dart';

/// Jogador do Nuclear 360.
///
/// Por ser um público adolescente, guardamos o mínimo (LGPD):
/// apelido e faixa etária, sem nome completo, CPF ou data de nascimento.
class Usuario {
  const Usuario({
    required this.apelido,
    required this.email,
    required this.perfil,
    required this.faixaEtaria,
    this.xp = 0,
  });

  final String apelido;
  final String email;
  final PerfilUsuario perfil;
  final String faixaEtaria;
  final int xp;

  Usuario copyWith({int? xp}) => Usuario(
        apelido: apelido,
        email: email,
        perfil: perfil,
        faixaEtaria: faixaEtaria,
        xp: xp ?? this.xp,
      );
}
