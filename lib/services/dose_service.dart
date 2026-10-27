import '../models/item_dose.dart';

/// Converte doses de radiação para a unidade do app: bananas.
class DoseService {
  const DoseService();

  /// Dose aproximada de comer uma banana, em microsievert.
  static const double doseBananaMicroSv = 0.1;

  double emBananas(double doseMicroSv) => doseMicroSv / doseBananaMicroSv;

  /// Soma a dose do "dia" montado pelo usuário (item → quantidade).
  double total(Map<ItemDose, int> quantidades) => quantidades.entries
      .fold<double>(0, (soma, e) => soma + e.key.doseMicroSievert * e.value);
}
