/// Configuração da conexão com a API Java do Nuclear 360.
///
/// A URL base pode ser trocada ao rodar, sem alterar o código:
///   dart run --define=API_URL=http://192.168.0.10:8080
///
/// Por padrão aponta para a API rodando na própria máquina (localhost),
/// que é o cenário da gravação: a API Java sobe local e o app a consome.
abstract final class ApiConfig {
  static const String baseUrl =
      String.fromEnvironment('API_URL', defaultValue: 'http://localhost:8080');

  /// Tempo máximo esperando a API antes de cair no mock.
  static const Duration timeout = Duration(seconds: 4);

  /// Quantas perguntas buscar da API para montar o quiz.
  static const int tamanhoQuiz = 5;
}
