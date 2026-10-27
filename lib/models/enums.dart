/// Áreas de aplicação da tecnologia nuclear citadas no desafio da AMAZUL.
enum AreaNuclear {
  saude('Saúde'),
  agricultura('Agricultura'),
  industria('Indústria'),
  pesquisa('Pesquisa'),
  energia('Energia');

  const AreaNuclear(this.rotulo);

  final String rotulo;
}

enum TipoMissao {
  quiz('Quiz'),
  swipe('Verdade ou Radioativo'),
  simulador('Simulador'),
  narrativa('Narrativa');

  const TipoMissao(this.rotulo);

  final String rotulo;
}

enum PerfilUsuario { jogador, professor, curador, admin }

/// Só conteúdo [aprovada] e com referência pode aparecer no app.
enum StatusCuradoria { rascunho, emRevisao, aprovada }
