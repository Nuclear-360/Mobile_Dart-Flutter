import 'dart:convert';
import 'dart:io';

import '../../models/quiz_item.dart';
import 'api_config.dart';

/// Cliente HTTP da API Java, usando só a biblioteca padrão (dart:io).
///
/// Fluxo: busca a página de perguntas em `GET /api/pergunta` e, para cada
/// pergunta, busca as alternativas em `GET /api/pergunta/{id}/with-resposta`.
class PerguntaApi {
  const PerguntaApi();

  Future<List<QuizItem>> buscarQuiz() async {
    final client = HttpClient()..connectionTimeout = ApiConfig.timeout;
    try {
      final ids = await _buscarIds(client);
      final itens = <QuizItem>[];
      for (final id in ids.take(ApiConfig.tamanhoQuiz)) {
        final item = await _buscarComResposta(client, id);
        if (item != null && item.alternativas.isNotEmpty) itens.add(item);
      }
      return itens;
    } finally {
      client.close(force: true);
    }
  }

  Future<List<int>> _buscarIds(HttpClient client) async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/api/pergunta?page=0&sizePage=${ApiConfig.tamanhoQuiz}',
    );
    final json = await _getJson(client, uri) as Map<String, dynamic>;
    final content = (json['content'] as List<dynamic>? ?? []);
    return content
        .map((e) => (e as Map<String, dynamic>)['id'] as int)
        .toList();
  }

  Future<QuizItem?> _buscarComResposta(HttpClient client, int id) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/pergunta/$id/with-resposta');
    final json = await _getJson(client, uri) as Map<String, dynamic>;

    final respostas = (json['respostas'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    if (respostas.isEmpty) return null;

    final alternativas = respostas
        .map((r) => QuizAlternativa(
              texto: (r['conteudo'] as String?) ?? '',
              correta: (r['respostaCerta'] as bool?) ?? false,
            ))
        .toList();

    // A explicação na API fica em cada resposta; usamos a da resposta correta.
    final correta = respostas.firstWhere(
      (r) => (r['respostaCerta'] as bool?) ?? false,
      orElse: () => respostas.first,
    );

    return QuizItem(
      enunciado: (json['enunciado'] as String?) ?? 'Pergunta',
      alternativas: alternativas,
      explicacao: (correta['explicacao'] as String?) ??
          'Sem explicação cadastrada para esta pergunta.',
      fonte: 'Backend Nuclear 360 (API Java)',
    );
  }

  Future<Object?> _getJson(HttpClient client, Uri uri) async {
    final req = await client.getUrl(uri);
    req.headers.set(HttpHeaders.acceptHeader, 'application/json');
    final resp = await req.close().timeout(ApiConfig.timeout);
    if (resp.statusCode != 200) {
      throw HttpException('Status ${resp.statusCode}', uri: uri);
    }
    final body = await resp.transform(utf8.decoder).join();
    return jsonDecode(body);
  }
}
