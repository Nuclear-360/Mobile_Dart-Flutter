import 'enums.dart';
import 'missao.dart';

/// Distrito do Mapa da Cidade. Cada um representa uma área de aplicação
/// da tecnologia nuclear e "acende" quando o jogador conclui suas missões.
class Distrito {
  const Distrito({
    required this.id,
    required this.nome,
    required this.area,
    required this.semNuclear,
    required this.comNuclear,
    required this.missoes,
  });

  final String id;
  final String nome;
  final AreaNuclear area;

  /// Como o distrito está no mundo de 2070, sem tecnologia nuclear.
  final String semNuclear;

  /// O benefício que volta quando o distrito é reacendido.
  final String comNuclear;

  final List<Missao> missoes;
}
