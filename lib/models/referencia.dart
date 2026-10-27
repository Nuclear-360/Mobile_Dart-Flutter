/// Fonte oficial que acompanha toda explicação exibida ao usuário.
class Referencia {
  const Referencia({
    required this.titulo,
    required this.instituicao,
    required this.url,
    this.ano,
  });

  final String titulo;
  final String instituicao;
  final String url;
  final int? ano;

  @override
  String toString() =>
      ano == null ? '$instituicao — $titulo' : '$instituicao ($ano) — $titulo';
}
