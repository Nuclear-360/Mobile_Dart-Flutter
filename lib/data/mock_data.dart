import '../models/alternativa.dart';
import '../models/cartao_mito.dart';
import '../models/distrito.dart';
import '../models/enums.dart';
import '../models/item_dose.dart';
import '../models/missao.dart';
import '../models/pergunta.dart';
import '../models/referencia.dart';

/// Dados mockados da Sprint 1. Na Sprint 2 eles passam a vir da API Java.
///
/// IMPORTANTE: as referências apontam para os portais institucionais.
/// Antes da entrega final, a curadoria deve trocar cada uma pelo link da
/// página específica que embasa a explicação, e validar os valores de dose.
abstract final class MockData {
  // ---------------------------------------------------------------------
  // Referências
  // ---------------------------------------------------------------------
  static const cnen = Referencia(
    titulo: 'Comissão Nacional de Energia Nuclear',
    instituicao: 'CNEN',
    url: 'https://www.gov.br/cnen',
  );

  static const aiea = Referencia(
    titulo: 'Agência Internacional de Energia Atômica',
    instituicao: 'AIEA',
    url: 'https://www.iaea.org',
  );

  static const amazul = Referencia(
    titulo: 'Amazônia Azul Tecnologias de Defesa',
    instituicao: 'AMAZUL',
    url: 'https://www.amazul.mar.mil.br',
  );

  // ---------------------------------------------------------------------
  // Distritos e missões do Mapa da Cidade
  // ---------------------------------------------------------------------
  static const List<Distrito> distritos = [
    Distrito(
      id: 'hospital',
      nome: 'Hospital',
      area: AreaNuclear.saude,
      semNuclear: 'sem radioterapia e sem medicina nuclear',
      comNuclear: 'diagnóstico por imagem, radioterapia e esterilização',
      missoes: [
        Missao(
          id: 'h1',
          distritoId: 'hospital',
          titulo: 'O que salva vidas',
          descricao: 'Mitos e fatos sobre a radiação na medicina.',
          tipo: TipoMissao.swipe,
        ),
        Missao(
          id: 'h2',
          distritoId: 'hospital',
          titulo: 'Raio-X da verdade',
          descricao: 'Quais exames e tratamentos usam tecnologia nuclear?',
          tipo: TipoMissao.quiz,
        ),
        Missao(
          id: 'h3',
          distritoId: 'hospital',
          titulo: 'Arquivo Goiânia',
          descricao: 'O que aconteceu em 1987 e o que mudou depois.',
          tipo: TipoMissao.narrativa,
          xp: 0,
          pontuavel: false,
        ),
      ],
    ),
    Distrito(
      id: 'fazenda',
      nome: 'Fazenda',
      area: AreaNuclear.agricultura,
      semNuclear: 'alimentos estragam e pragas avançam',
      comNuclear: 'alimentos mais duráveis e controle de pragas',
      missoes: [
        Missao(
          id: 'f1',
          distritoId: 'fazenda',
          titulo: 'Comida que dura',
          descricao: 'Como a irradiação conserva alimentos com segurança.',
          tipo: TipoMissao.quiz,
        ),
        Missao(
          id: 'f2',
          distritoId: 'fazenda',
          titulo: 'Praga sob controle',
          descricao: 'A técnica do inseto estéril no campo.',
          tipo: TipoMissao.swipe,
        ),
      ],
    ),
    Distrito(
      id: 'fabrica',
      nome: 'Fábrica',
      area: AreaNuclear.industria,
      semNuclear: 'soldas de pontes e dutos sem inspeção',
      comNuclear: 'inspeção de soldas e medidores industriais',
      missoes: [
        Missao(
          id: 'i1',
          distritoId: 'fabrica',
          titulo: 'Inspeção invisível',
          descricao: 'Como a radiação enxerga dentro do metal.',
          tipo: TipoMissao.quiz,
        ),
      ],
    ),
    Distrito(
      id: 'laboratorio',
      nome: 'Laboratório',
      area: AreaNuclear.pesquisa,
      semNuclear: 'pesquisa parada, sem datação de fósseis',
      comNuclear: 'datação por carbono-14 e traçadores',
      missoes: [
        Missao(
          id: 'l1',
          distritoId: 'laboratorio',
          titulo: 'Radiação no dia a dia',
          descricao: 'A radiação natural que está à sua volta.',
          tipo: TipoMissao.swipe,
        ),
        Missao(
          id: 'l2',
          distritoId: 'laboratorio',
          titulo: 'Relógio do carbono',
          descricao: 'Como a ciência descobre a idade das coisas.',
          tipo: TipoMissao.quiz,
        ),
      ],
    ),
    Distrito(
      id: 'usina',
      nome: 'Usina e Porto',
      area: AreaNuclear.energia,
      semNuclear: 'apagões diários e submarinos parados',
      comNuclear: 'energia firme e propulsão naval',
      missoes: [
        Missao(
          id: 'u1',
          distritoId: 'usina',
          titulo: 'Reator não é bomba',
          descricao: 'Por que uma usina não explode como uma arma.',
          tipo: TipoMissao.swipe,
        ),
        Missao(
          id: 'u2',
          distritoId: 'usina',
          titulo: 'Comande o Reator',
          descricao: 'Mantenha o reator estável com as barras de controle.',
          tipo: TipoMissao.simulador,
          xp: 100,
        ),
        Missao(
          id: 'u3',
          distritoId: 'usina',
          titulo: 'Do minério ao submarino',
          descricao: 'O ciclo do combustível e o Programa Nuclear da Marinha.',
          tipo: TipoMissao.narrativa,
        ),
      ],
    ),
  ];

  // ---------------------------------------------------------------------
  // Verdade ou Radioativo
  // ---------------------------------------------------------------------
  static const List<CartaoMito> cartoes = [
    CartaoMito(
      id: 'c1',
      afirmacao: 'Uma usina nuclear pode explodir como uma bomba atômica.',
      ehVerdade: false,
      explicacao: 'O combustível de um reator tem urânio enriquecido a cerca '
          'de 3% a 5%, enquanto uma arma exige cerca de 90%. Essa diferença '
          'torna impossível uma explosão nuclear como a de uma bomba.',
      referencias: [cnen, aiea],
    ),
    CartaoMito(
      id: 'c2',
      afirmacao: 'Bananas são levemente radioativas.',
      ehVerdade: true,
      explicacao: 'Bananas contêm potássio-40, um isótopo natural. A dose de '
          'comer uma banana é minúscula, cerca de 0,1 microsievert.',
      referencias: [cnen],
    ),
    CartaoMito(
      id: 'c3',
      afirmacao: 'Alimentos irradiados ficam radioativos.',
      ehVerdade: false,
      explicacao: 'A irradiação elimina micro-organismos e pragas, mas não '
          'deixa o alimento radioativo, assim como uma mala não fica '
          'radioativa ao passar pelo raio-X do aeroporto.',
      referencias: [aiea],
    ),
    CartaoMito(
      id: 'c4',
      afirmacao: 'A medicina nuclear ajuda a diagnosticar e tratar o câncer.',
      ehVerdade: true,
      explicacao: 'Exames como a cintilografia e o PET usam radiofármacos '
          'para mostrar o funcionamento dos órgãos, e a radioterapia '
          'destrói células tumorais.',
      referencias: [cnen],
    ),
    CartaoMito(
      id: 'c5',
      afirmacao: 'As areias de Guarapari (ES) têm radiação natural acima da '
          'média.',
      ehVerdade: true,
      explicacao: 'Elas contêm monazita, um mineral rico em tório. A cidade '
          'é um destino turístico conhecido há décadas.',
      referencias: [cnen],
    ),
    CartaoMito(
      id: 'c6',
      afirmacao: 'O acidente de Goiânia aconteceu em uma usina nuclear.',
      ehVerdade: false,
      explicacao: 'Em 1987, uma cápsula de césio-137 de um aparelho de '
          'radioterapia abandonado foi aberta por pessoas que não conheciam '
          'o risco. Nenhuma usina esteve envolvida.',
      referencias: [cnen],
    ),
    CartaoMito(
      id: 'c7',
      afirmacao: 'O submarino de propulsão nuclear usa o reator para se mover, '
          'não como arma.',
      ehVerdade: true,
      explicacao: 'O reator gera energia para a propulsão e permite que o '
          'submarino fique muito tempo submerso. O Programa Nuclear da '
          'Marinha desenvolve essa tecnologia no Brasil.',
      referencias: [amazul],
    ),
    CartaoMito(
      id: 'c8',
      afirmacao: 'A castanha-do-pará é um dos alimentos mais radioativos que '
          'existem.',
      ehVerdade: true,
      explicacao: 'As raízes da castanheira absorvem rádio do solo. Mesmo '
          'assim, comer castanhas normalmente é seguro.',
      referencias: [aiea],
    ),
  ];

  // ---------------------------------------------------------------------
  // Quiz
  // ---------------------------------------------------------------------
  static const List<Pergunta> perguntas = [
    Pergunta(
      id: 'p1',
      missaoId: 'h2',
      enunciado: 'Qual destes exames usa medicina nuclear?',
      alternativas: [
        Alternativa(id: 'a', texto: 'Ultrassom'),
        Alternativa(id: 'b', texto: 'Cintilografia', correta: true),
        Alternativa(id: 'c', texto: 'Eletrocardiograma'),
        Alternativa(id: 'd', texto: 'Ressonância magnética'),
      ],
      explicacao: 'Na cintilografia, o paciente recebe uma pequena dose de '
          'radiofármaco e um equipamento capta a radiação para formar a '
          'imagem do órgão. Ultrassom e ressonância não usam radiação '
          'ionizante.',
      referencias: [cnen],
    ),
    Pergunta(
      id: 'p2',
      missaoId: 'u1',
      enunciado: 'Qual o enriquecimento típico do urânio usado em usinas?',
      alternativas: [
        Alternativa(id: 'a', texto: 'Cerca de 3% a 5%', correta: true),
        Alternativa(id: 'b', texto: 'Cerca de 50%'),
        Alternativa(id: 'c', texto: 'Cerca de 90%'),
        Alternativa(id: 'd', texto: '100%'),
      ],
      explicacao: 'Usinas de energia usam urânio levemente enriquecido. '
          'Níveis próximos de 90% são característicos de armas, e por isso '
          'o combustível de uma usina não pode explodir como uma bomba.',
      referencias: [aiea],
    ),
  ];

  // ---------------------------------------------------------------------
  // Medidor de Bananas (valores aproximados, a validar pela curadoria)
  // ---------------------------------------------------------------------
  static const List<ItemDose> itensDose = [
    ItemDose(
      id: 'banana',
      nome: 'Comer uma banana',
      doseMicroSievert: 0.1,
      referencia: cnen,
    ),
    ItemDose(
      id: 'dia-natural',
      nome: 'Um dia de radiação natural',
      doseMicroSievert: 6.6,
      referencia: cnen,
    ),
    ItemDose(
      id: 'raio-x-torax',
      nome: 'Raio-X de tórax',
      doseMicroSievert: 20,
      referencia: cnen,
    ),
    ItemDose(
      id: 'voo-10h',
      nome: 'Voo de 10 horas',
      doseMicroSievert: 40,
      referencia: aiea,
    ),
    ItemDose(
      id: 'tomografia-torax',
      nome: 'Tomografia de tórax',
      doseMicroSievert: 7000,
      referencia: cnen,
    ),
  ];
}
