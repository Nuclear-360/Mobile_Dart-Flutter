import 'referencia.dart';

/// Item do Medidor de Bananas (uma situação do dia a dia e sua dose).
class ItemDose {
  const ItemDose({
    required this.id,
    required this.nome,
    required this.doseMicroSievert,
    required this.referencia,
  });

  final String id;
  final String nome;

  /// Dose aproximada em microsievert (µSv).
  final double doseMicroSievert;

  final Referencia referencia;
}
