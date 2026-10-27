import 'enums.dart';

class Missao {
  const Missao({
    required this.id,
    required this.distritoId,
    required this.titulo,
    required this.descricao,
    required this.tipo,
    this.xp = 50,
    this.pontuavel = true,
  });

  final String id;
  final String distritoId;
  final String titulo;
  final String descricao;
  final TipoMissao tipo;
  final int xp;

  /// Falso para conteúdos sensíveis, como o Arquivo Goiânia (sem XP).
  final bool pontuavel;
}
