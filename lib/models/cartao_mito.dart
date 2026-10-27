import 'enums.dart';
import 'referencia.dart';

/// Card do "Verdade ou Radioativo": uma afirmação que o jogador
/// classifica como verdade ou mito.
class CartaoMito {
  const CartaoMito({
    required this.id,
    required this.afirmacao,
    required this.ehVerdade,
    required this.explicacao,
    required this.referencias,
    this.status = StatusCuradoria.aprovada,
  });

  final String id;
  final String afirmacao;
  final bool ehVerdade;
  final String explicacao;
  final List<Referencia> referencias;
  final StatusCuradoria status;

  bool get publicavel =>
      status == StatusCuradoria.aprovada && referencias.isNotEmpty;
}
