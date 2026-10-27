class Alternativa {
  const Alternativa({
    required this.id,
    required this.texto,
    this.correta = false,
  });

  final String id;
  final String texto;
  final bool correta;
}
